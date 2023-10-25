import 'package:flutter/material.dart';

import '../Utils/theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final Function()? onMoreTap;

  const TitleView({
    super.key,
    this.titleTxt = "",
    this.subTxt = "",
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      width: 75,
                      child: Container(
                        height: 0,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppTheme.themeColor,
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xAA9FC0AF),
                                AppTheme.gradientColor,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                      ),
                    ),
                    Text(
                      titleTxt,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: AppTheme.lightText,
                      ),
                    ),
                  ],
                ),
                // Text(
                //   subTxt,
                //   textAlign: TextAlign.left,
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w300,
                //     fontSize: 14,
                //     letterSpacing: 0.5,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            onTap: onMoreTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 34,
                    margin: const EdgeInsets.only(top: 3),
                    child: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppTheme.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
