import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/hex_color.dart';
import 'package:cloudreader/Widgets/github_calendar.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Post/login_screen.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  static const String routeName = "/nav/personal";

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<Color> gradientColors = [
    AppTheme.themeColor,
    AppTheme.nearlyBlue,
  ];
  List<String> moods = ["不开心", "郁闷", "普通", "好心情", "开心"];
  String diaryWordCount = "0";
  int postCount = 0;
  int replyCount = 0;
  int day = 1;

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController!.forward();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: RefreshIndicator(
          color: AppTheme.themeColor,
          onRefresh: () async {
          },
          child: SingleChildScrollView(
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: const Icon(
                            Iconfont.gengduo,
                            size: 23,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  _head(),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _scale(
                                  title: "MBTI人格测试",
                                  content: "INFJ-L",
                                  background: HexColor('#F0F1FC')),
                            ),
                            Expanded(
                              child: _scale(
                                  title: "霍兰德职业兴趣测试",
                                  content: "兴趣型",
                                  background: HexColor('#EBEDF0')),
                            ),
                          ],
                        ),
                        _analysis(),
                        _meditation(),
                        _mood(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _head() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10), bottom: Radius.circular(10)),
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "未登录",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      letterSpacing: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: const Text(
                      "登录以记录与噬云相遇的点滴",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: ClipOval(
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _analysis() {
    return _bigCard(
        showDetail: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: _card(
                  title: "日记",
                  count: diaryWordCount,
                  scale: "字",
                  background: HexColor('#F0F1FC'),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: _card(
                  title: "树洞",
                  count: "$postCount",
                  scale: "帖",
                  background: HexColor('#F3FBFD'),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: _card(
                  title: "回答",
                  count: "$replyCount",
                  scale: "条",
                  background: HexColor('#FEF3F0'),
                ),
              ),
            ],
          ),
        ),
        title: "统计");
  }

  Widget _scale({
    required String title,
    required String content,
    Color? color = AppTheme.themeColor,
    required Color background,
  }) {
    return _bigCard(
        onDetailTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            )
          ],
        ),
        title: title,
        background: background);
  }

  Widget _meditation() {
    return _bigCard(
      title: "冥想日历",
      onDetailTap: () {},
      child: Column(children: [
        const SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: GithubCalendar(
            style: const TextStyle(fontSize: 9, color: AppTheme.themeColor),
            color: AppTheme.themeColor,
            initialColor: HexColor('#F0F1FC'),
            data: List.generate(120, (index) {
              return Random().nextInt(5);
            }),
          ),
        ),
      ]),
    );
  }

  Widget _mood() {
    return _bigCard(
      title: "心情曲线",
      titleIcon: Iconfont.bangzhu,
      onDetailTap: () {},
      onTitleIconTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('心情曲线'),
                content: const Text('心情曲线基于您撰写的心晴日记生成'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      '确定',
                      style: TextStyle(color: AppTheme.themeColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context, "确定");
                    },
                  ),
                ],
              );
            });
      },
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 140,
                  child: LineChart(
                    mainData(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _bigCard({
    required Widget child,
    Color? background = AppTheme.white,
    required String title,
    IconData? titleIcon,
    bool showDetail = true,
    Function()? onTitleIconTap,
    Function()? onDetailTap,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: InkWell(
        onTap: () {
          if (onDetailTap != null) onDetailTap();
        },
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(10)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10), bottom: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.2,
                          color: AppTheme.lightText,
                        ),
                      ),
                      titleIcon != null
                          ? InkWell(
                              onTap: onTitleIconTap,
                              child: Container(
                                margin: const EdgeInsets.only(left: 3, top: 1),
                                child: Icon(titleIcon,
                                    color: AppTheme.lightText, size: 13),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  Visibility(
                    visible: showDetail,
                    child: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppTheme.lightText,
                      size: 18,
                    ),
                  ),
                ],
              ),
              child
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({
    required String title,
    required String count,
    required String scale,
    required Color background,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(10)),
        child: Ink(
          padding: const EdgeInsets.only(right: 20, left: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10), bottom: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.2,
                      color: AppTheme.lightText,
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      count,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppTheme.darkerText,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3, top: 1),
                      child: Text(
                        scale,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.themeColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.themeColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 20,
            getTitlesWidget: (double value, TitleMeta meta) {
              var date =
                  DateTime.now().subtract(Duration(days: 14 - value.toInt()));
              late String txt;
              if (date.day == 1 || value == 0 || value == 14) {
                txt = '${date.month}-${date.day}';
              } else {
                txt = '${date.day}';
              }
              return Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  txt,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                    fontWeight: FontWeight.normal,
                    fontSize: 9,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) {
              String txt = '';
              switch (value.toInt()) {
                case 1:
                  txt = moods[0];
                  break;
                case 2:
                  txt = moods[1];
                  break;
                case 3:
                  txt = moods[2];
                  break;
                case 4:
                  txt = moods[3];
                  break;
                case 5:
                  txt = moods[4];
                  break;
              }
              return Text(
                txt,
                style: const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: AppTheme.spacer, width: 0.5),
      ),
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 6,
      lineBarsData: linesBarData(),
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> indicators) {
          return indicators.map((int index) {
            var lineColor = AppTheme.themeColor;
            const lineStrokeWidth = 2.0;
            final flLine = FlLine(
              color: lineColor,
              strokeWidth: lineStrokeWidth,
            );
            var dotSize = 4.0;

            final dotData = FlDotData(
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: dotSize,
                  color: AppTheme.themeColor,
                  strokeColor: Colors.transparent),
            );
            return TouchedSpotIndicatorData(flLine, dotData);
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: AppTheme.themeColor,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              var date = DateTime.now()
                  .subtract(Duration(days: 14 - flSpot.x.toInt()));
              late String txt = '${date.month}月${date.day}日';

              return LineTooltipItem(
                '$txt\n',
                const TextStyle(
                  color: AppTheme.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: moods[(flSpot.y.toInt() + 4) % 5],
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
                textAlign: TextAlign.center,
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<LineChartBarData> linesBarData() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: const [
        FlSpot(0, 3),
        FlSpot(1, 2),
        FlSpot(2, 5),
        FlSpot(3, 3),
        FlSpot(4, 1),
        FlSpot(5, 3),
        FlSpot(6, 2),
        FlSpot(7, 5),
        FlSpot(8, 1),
        FlSpot(9, 4),
        FlSpot(10, 3),
        FlSpot(11, 4),
        FlSpot(12, 3),
        FlSpot(13, 4),
        FlSpot(14, 3),
      ],
      showingIndicators: [1, 2, 3],
      isCurved: true,
      barWidth: 2,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: gradientColors,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
        spotsLine: BarAreaSpotsLine(
          show: true,
          flLineStyle: FlLine(
            color: AppTheme.themeColor,
            strokeWidth: 1,
            dashArray: [1, 2, 3, 4, 5],
          ),
          checkToShowSpotLine: (spot) {
            if (spot.x == 0 || spot.x == 14) {
              return false;
            }
            return true;
          },
        ),
      ),
    );
    return [lineChartBarData1];
  }
}
