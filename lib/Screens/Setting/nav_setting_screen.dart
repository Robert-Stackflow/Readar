import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Providers/provider_manager.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Custom/salomon_bottom_bar.dart';
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
  List<DragAndDropList> _contents = [];
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

  @override
  void didChangeDependencies() {
    initList();
    updateNavBar();
    super.didChangeDependencies();
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
              showTrailing: false,
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
              showTrailing: false,
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
        title: _navHasItem
            ? S.current.navigationBarEntries
            : S.current.allEntriesHidddenTip);
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
    ProviderManager.globalProvider.navEntries = navs;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      return Scaffold(
        appBar: ItemBuilder.buildSimpleAppBar(
          title: S.current.bottomNavigationBarSetting,
          context: context,
          // actions: [
          //   IconButton(
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     icon: Icon(Icons.refresh_rounded,
          //         color: IconTheme.of(context).color),
          //     onPressed: () {
          //       globalProvider.navEntries = NavEntry.defaultEntries;
          //       setState(() {
          //         initList();
          //         updateNavBar();
          //         IPrint.debug("text");
          //       });
          //     },
          //   ),
          // ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                globalProvider.showNavigationBar && _contents.isNotEmpty
                    ? DragAndDropLists(
                        children: _contents,
                        onItemReorder: _onItemReorder,
                        listPadding: const EdgeInsets.only(bottom: 10),
                        onListReorder: (_, __) {},
                        lastItemTargetHeight: 0,
                        lastListTargetSize: 60,
                        sliverList: true,
                        scrollController: _scrollController,
                        itemDragOnLongPress: false,
                        itemGhostOpacity: 0.3,
                        itemOpacityWhileDragging: 0.7,
                        itemDragHandle: DragHandle(
                          child: IconButton(
                            icon: Icon(
                              Icons.dehaze_rounded,
                              size: 20,
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                            ),
                            onPressed: () {},
                          ),
                        ),
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
            title: Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(S.current.navigationBarPreview,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (index) => setState(() => _selectedIndex = index),
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
      IToast.showTop(
        context,
        text: S.current.navigationBarMaxEntriesTip(NavEntry.maxShown),
      );
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
