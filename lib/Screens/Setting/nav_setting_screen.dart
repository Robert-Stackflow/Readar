import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Providers/global.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Draggable/drag_and_drop_lists.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class NavSettingScreen extends StatefulWidget {
  const NavSettingScreen({super.key});

  static const String routeName = "/setting/nav";

  @override
  State<NavSettingScreen> createState() => _NavSettingScreenState();
}

class _NavSettingScreenState extends State<NavSettingScreen>
    with TickerProviderStateMixin {
  late List<DragAndDropList> _contents;
  List<SalomonBottomBarItem> _navigationBarItemList = [];
  int _selectedIndex = 0;
  bool _navHasItem = true;
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initList();
      updateNavBar();
    });
  }

  void initList() {
    List<NavEntry> navigationBarEntries = NavEntry.getNavigationBarEntries();
    List<NavEntry> sidebarEntries = NavEntry.getSidebarEntries();
    _contents = <DragAndDropList>[
      DragAndDropList(
        canDrag: false,
        header: ItemBuilder.buildCaptionItem(
            context: context,
            title: _navHasItem
                ? S.current.navigationBarEntries
                : S.current.allEntriesHidddenTip),
        lastTarget: ItemBuilder.buildCaptionItem(
            context: context,
            title: S.current.dragTip,
            topRadius: false,
            bottomRadius: true),
        contentsWhenEmpty: Container(),
        children: List.generate(
          navigationBarEntries.length,
          (index) => DragAndDropItem(
            child: ItemBuilder.buildEntryItem(
              context: context,
              title: NavEntry.getLabel(navigationBarEntries[index].id),
              trailing: Icons.dehaze_rounded,
            ),
            data: navigationBarEntries[index],
          ),
        ),
      ),
      DragAndDropList(
        canDrag: false,
        header: ItemBuilder.buildCaptionItem(
            context: context, title: S.current.sidebarEntries),
        lastTarget: ItemBuilder.buildCaptionItem(
            context: context,
            title: S.current.dragTip,
            topRadius: false,
            bottomRadius: true),
        children: List.generate(
          sidebarEntries.length,
          (index) => DragAndDropItem(
            child: ItemBuilder.buildEntryItem(
              context: context,
              title: NavEntry.getLabel(sidebarEntries[index].id),
              trailing: Icons.dehaze_rounded,
            ),
            data: sidebarEntries[index],
          ),
        ),
      ),
    ];
  }

  void updateNavBar() {
    setState(() {
      _selectedIndex = 0;
      _navigationBarItemList = [];
      for (DragAndDropItem item in _contents[0].children) {
        _navigationBarItemList.add(SalomonBottomBarItem(
            icon: Icon(NavEntry.getIcon((item.data as NavEntry).id)),
            title: Text(NavEntry.getLabel((item.data as NavEntry).id))));
      }
      _navHasItem = _navigationBarItemList.isNotEmpty;
    });
    _contents[0].header = ItemBuilder.buildCaptionItem(
        context: context,
        title: _navHasItem ? "显示在导航栏的入口" : "所有入口均移至侧边栏，导航栏将不再显示");
  }

  void persist() {
    List<NavEntry> navs = [];
    int cur = 0;
    for (DragAndDropItem item in _contents[0].children) {
      NavEntry data = item.data;
      data.visible = true;
      data.index = cur;
      cur += 1;
      navs.add(data);
    }
    for (DragAndDropItem item in _contents[1].children) {
      NavEntry data = item.data;
      data.visible = false;
      data.index = cur;
      cur += 1;
      navs.add(data);
    }
    Global.globalProvider.navEntries = navs;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      return Container(
        color: Colors.transparent,
        child: Scaffold(
          appBar: ItemBuilder.buildAppBar(
            title: S.current.bottomNavigationBarSetting,
            context: context,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ScrollConfiguration(
              behavior: NoShadowScrollBehavior(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ItemBuilder.buildRadioItem(
                        context: context,
                        title: S.current.showNavigationBar,
                        value: globalProvider.showNavigationBar,
                        topRadius: true,
                        bottomRadius: true,
                        onTap: () {
                          setState(() {
                            globalProvider.showNavigationBar =
                                !globalProvider.showNavigationBar;
                          });
                        },
                      ),
                    ),
                  ),
                  globalProvider.showNavigationBar
                      ? DragAndDropLists(
                          children: _contents,
                          onItemReorder: _onItemReorder,
                          listPadding: const EdgeInsets.only(bottom: 10),
                          onListReorder: (_, __) {},
                          lastItemTargetHeight: 0,
                          sliverList: true,
                          scrollController: _scrollController,
                        )
                      : SliverToBoxAdapter(child: Container()),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Visibility(
            visible: globalProvider.showNavigationBar && _navHasItem,
            child: SalomonBottomBar(
              margin: const EdgeInsets.all(10),
              items: _navigationBarItemList,
              currentIndex: _selectedIndex,
              backgroundColor: Theme.of(context).canvasColor,
              selectedItemColor: Theme.of(context).primaryColor,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
      );
    });
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    if (newListIndex == 0 &&
        oldListIndex == 1 &&
        _contents[0].children.length >= NavEntry.maxShown) {
      IToast.showTop(context, text: "导航栏最多显示${NavEntry.maxShown}个入口");
    } else {
      setState(() {
        var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
        _contents[newListIndex].children.insert(newItemIndex, movedItem);
      });
      persist();
      updateNavBar();
    }
  }
}