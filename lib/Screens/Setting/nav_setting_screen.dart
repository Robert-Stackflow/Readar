import 'package:cloudreader/Models/nav_data.dart';
import 'package:cloudreader/Providers/global.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../Utils/theme.dart';
import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Draggable/drag_and_drop_lists.dart';
import '../../Widgets/Item/entry_item.dart';
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
    initList();
    updateNavBar();
  }

  void initList() {
    List<NavData> shownNavs = NavData.getShownNavs();
    List<NavData> hiddenNavs = NavData.getHiddenNavs();
    _contents = <DragAndDropList>[
      DragAndDropList(
        canDrag: false,
        header: ItemBuilder.buildCaptionItem(
          title: _navHasItem ? "显示在导航栏的入口" : "所有入口均移至侧边栏，导航栏将不再显示",
          topRadius: true,
        ),
        lastTarget: ItemBuilder.buildCaptionItem(
          title: "长按项目拖动到此处，将其移至列表末尾",
          bottomRadius: true,
        ),
        contentsWhenEmpty: Container(),
        children: List.generate(
          shownNavs.length,
          (index) => DragAndDropItem(
            child: EntryItem(
              title: NavData.getLabel(shownNavs[index].id),
              trailing: Icons.dehaze_rounded,
            ),
            data: shownNavs[index],
          ),
        ),
      ),
      DragAndDropList(
        canDrag: false,
        header:
            ItemBuilder.buildCaptionItem(title: "显示在侧边栏的入口", topRadius: true),
        lastTarget: ItemBuilder.buildCaptionItem(
            title: "长按项目拖动到此处，将其移至列表末尾", bottomRadius: true),
        children: List.generate(
          hiddenNavs.length,
          (index) => DragAndDropItem(
            child: EntryItem(
              title: NavData.getLabel(hiddenNavs[index].id),
              trailing: Icons.dehaze_rounded,
            ),
            data: hiddenNavs[index],
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
            icon: Icon(NavData.getIcon((item.data as NavData).id)),
            title: Text(NavData.getLabel((item.data as NavData).id))));
      }
      _navHasItem = _navigationBarItemList.isNotEmpty;
    });
    _contents[0].header = ItemBuilder.buildCaptionItem(
      title: _navHasItem ? "显示在导航栏的入口" : "所有入口均移至侧边栏，导航栏将不再显示",
      topRadius: true,
    );
  }

  void persist() {
    List<NavData> navs = [];
    int cur = 0;
    for (DragAndDropItem item in _contents[0].children) {
      NavData data = item.data;
      data.visible = true;
      data.index = cur;
      cur += 1;
      navs.add(data);
    }
    for (DragAndDropItem item in _contents[1].children) {
      NavData data = item.data;
      data.visible = false;
      data.index = cur;
      cur += 1;
      navs.add(data);
    }
    Global.globalProvider.navData = navs;
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
                        title: S.current.showNavBar,
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
              backgroundColor: AppTheme.white,
              selectedItemColor: AppTheme.themeColor,
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
        _contents[0].children.length >= NavData.maxShown) {
      IToast.showTop(context, text: "导航栏最多显示${NavData.maxShown}个入口");
    } else {
      setState(() {
        var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
        _contents[newListIndex].children.insert(newItemIndex, movedItem);
      });
      persist();
      updateNavBar();
    }
  }

  updateBottomRadius() {
    for (DragAndDropItem widget in _contents[0].children) {
      (widget.child as EntryItem).setBottomRadius(false);
    }
    for (DragAndDropItem widget in _contents[1].children) {
      (widget.child as EntryItem).setBottomRadius(false);
    }
    if (_contents[0].children.isNotEmpty) {
      (_contents[0].children.last.child as EntryItem).setBottomRadius(true);
    }
    if (_contents[1].children.isNotEmpty) {
      (_contents[1].children.last.child as EntryItem).setBottomRadius(true);
    }
  }
}
