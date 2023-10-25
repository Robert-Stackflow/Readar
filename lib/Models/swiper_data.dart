class SwiperData {
  SwiperData({
    this.imagePath = '',
    this.title = '',
    this.description = '',
    this.tag = '',
    this.score = 5,
    required this.onTap,
  });

  String tag;
  String imagePath;
  String title;
  double score;
  String description;
  Function() onTap;

  static List<SwiperData> homeSwiperData = <SwiperData>[];
}
