import 'package:cloudreader/Themes/theme.dart';
import 'package:flutter/material.dart';

class SearchType {
  SearchType({required this.label});

  String label;
  static final SearchType post = SearchType(label: "帖子");
  static final SearchType question = SearchType(label: "问题");
  static final SearchType meditation = SearchType(label: "冥想");
  static final SearchType pedia = SearchType(label: "百科");
  static final SearchType book = SearchType(label: "书籍");
  static final SearchType video = SearchType(label: "影视");
  static final SearchType exercise = SearchType(label: "运动");
  static List<SearchType> types = [
    post,
    question,
    meditation,
    pedia,
    book,
    video,
    exercise
  ];
}

class SearchBottomSheet extends StatelessWidget {
  const SearchBottomSheet({
    Key? key,
    required this.type,
  }) : super(key: key);

  final SearchType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(4),
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 24,
            alignment: Alignment.center,
            // color: Colors.white.withOpacity(0.2),
            child: Text(
              "搜索${type.label}",
              style: AppTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: const <Widget>[
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '是假用户哟',
          style: AppTheme.title,
        ),
        Container(height: 2),
        const Text(
          '这是一条模拟评论，主播666啊。',
          style: AppTheme.caption,
        ),
      ],
    );
    Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        Text(
          '54',
          style: AppTheme.caption,
        ),
      ],
    );
    right = Opacity(
      opacity: 0.3,
      child: right,
    );
    var avatar = Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: SizedBox(
        height: 36,
        width: 36,
        child: ClipOval(
          child: Image.network(
            "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          avatar,
          Expanded(child: info),
          right,
        ],
      ),
    );
  }
}
