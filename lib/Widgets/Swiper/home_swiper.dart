import 'package:cloudreader/Models/swiper_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../Screens/Post/chat_screen.dart';
import '../../Themes/theme.dart';

final List<SwiperData> data = SwiperData.homeSwiperData;

class HomeSwiper extends StatelessWidget {
  const HomeSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                switch (index) {
                  case 0:
                    break;
                  case 1:
                    break;
                  case 2:
                    Navigator.pushNamed(context, ChatScreen.routeName);
                    break;
                  case 3:
                    break;
                  case 4:
                    break;
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child:
                        Image.asset(data[index].imagePath, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data[index].description,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                letterSpacing: 0.27,
                                color: AppTheme.spacer,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                            letterSpacing: 0.27,
                            color: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: data.length,
        // pagination: const SwiperPagination(
        //   alignment: Alignment.bottomLeft,
        //   margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 20),
        //   builder: DotSwiperPaginationBuilder(
        //     activeColor: AppTheme.white,
        //     color: Color(0x44FFFFFF),
        //     size: 3,
        //     activeSize: 4,
        //   ),
        // ),
      ),
    );
  }
}
