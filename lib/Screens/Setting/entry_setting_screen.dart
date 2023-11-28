import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Providers/provider_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Draggable/drag_and_drop_lists.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class EntrySettingScreen extends StatefulWidget {
  const EntrySettingScreen({super.key});

  static const String routeName = "/setting/entry";

  @override
  State<EntrySettingScreen> createState() => _EntrySettingScreenState();
}

class _EntrySettingScreenState extends State<EntrySettingScreen>
    with TickerProviderStateMixin {
  List<DragAndDropList> _contents = [];
  bool _allShown = false;
  bool _allHidden = false;
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
    List<NavEntry> shownEntries = NavEntry.getShownEntries();
    List<NavEntry> hiddenEntries = NavEntry.getHiddenEntries();
    _contents = <DragAndDropList>[
      DragAndDropList(
        canDrag: false,
        header: ItemBuilder.buildCaptionItem(
            context: context,
            title: _allHidden
                ? S.current.allEntriesHiddenTip
                : S.current.shownEntries),
        lastTarget: ItemBuilder.buildCaptionItem(
            context: context,
            title: S.current.dragTip,
            topRadius: false,
            bottomRadius: true),
        contentsWhenEmpty: Container(),
        children: List.generate(
          shownEntries.length,
          (index) => DragAndDropItem(
            child: ItemBuilder.buildEntryItem(
              context: context,
              title: NavEntry.getLabel(shownEntries[index].id),
              showTrailing: false,
            ),
            data: shownEntries[index],
          ),
        ),
      ),
      DragAndDropList(
        canDrag: false,
        header: ItemBuilder.buildCaptionItem(
            context: context,
            title: _allShown
                ? S.current.allEntriesShownTip
                : S.current.hiddenEntries(S.current.library)),
        lastTarget: ItemBuilder.buildCaptionItem(
            context: context,
            title: S.current.dragTip,
            topRadius: false,
            bottomRadius: true),
        contentsWhenEmpty: Container(),
        children: List.generate(
          hiddenEntries.length,
          (index) => DragAndDropItem(
            child: ItemBuilder.buildEntryItem(
              context: context,
              title: NavEntry.getLabel(hiddenEntries[index].id),
              showTrailing: false,
            ),
            data: hiddenEntries[index],
          ),
        ),
      ),
    ];
  }

  void updateNavBar() {
    _allShown = _contents[1].children.isEmpty;
    _allHidden = _contents[0].children.isEmpty;
    _contents[0].header = ItemBuilder.buildCaptionItem(
        context: context,
        title: _allHidden
            ? S.current.allEntriesHiddenTip
            : S.current.shownEntries);
    _contents[1].header = ItemBuilder.buildCaptionItem(
        context: context,
        title: _allShown
            ? S.current.allEntriesShownTip
            : S.current.hiddenEntries(S.current.library));
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
          title: S.current.sideBarEntriesSetting,
          context: context,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                _contents.isNotEmpty
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
                            child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ItemBuilder.buildIconButton(
                              context: context,
                              icon: Icon(
                                Icons.dehaze_rounded,
                                size: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.color,
                              ),
                              onTap: () {}),
                        )),
                      )
                    : SliverToBoxAdapter(child: Container()),
              ],
            ),
          ),
        ),
      );
    });
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
    persist();
    updateNavBar();
  }
}
