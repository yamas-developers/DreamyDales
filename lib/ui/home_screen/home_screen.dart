
import 'package:flutter/material.dart';

import '../../common_widgets/public_methods.dart';
import '../../constants.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> storiesItems = [
    {
      'image': "assets/images/cat_reading_book.png",
      'title': "The Cat Does Not\nSleep",
      'clock': "assets/icons/clock.png",
      'time': "20 min",
      'playButton':"assets/icons/play.png",
    },
    {
      'image': "assets/images/moon_in_night.png",
      'title': "Gift for the Moon",
      'clock': "assets/icons/clock.png",
      'time': "11 min",
      'playButton':"assets/icons/play.png",
    },
    {
      'image': "assets/images/girl_doing_magic.png",
      'title': "Believing in Magic",
      'clock': "assets/icons/clock.png",
      'time': "9 min",
      'playButton':"assets/icons/lock.png",
    },
    {
      'image': "assets/images/candy_land.png",
      'title': "Candy Land",
      'clock': "assets/icons/clock.png",
      'time': "20 min",
      'playButton':"assets/icons/lock.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 5,
        title: PublicText(
          title: "Bedtime Stories",
          fontSize: 19,
          fontWeight: FontWeight.w500,
          titleColor: whiteColor,
        ),
        actions: [
          AppBarWidget(
            image: "assets/icons/music_library.png",
            height: 22,
            width: 22,
            onTap: (){},
          ),
          AppBarWidget(
            image: "assets/icons/internet.png",
            height: 22,
            width: 22,
            onTap: (){},
          ),
          AppBarWidget(
            image: "assets/icons/setting.png",
            height: 22,
            width: 22,
            onTap: (){
              Navigator.pushNamed(context, "settingsScreen");
            },
          ),
          const Sbw(width: 0.02,)
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mainColor, primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height:110,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PublicText(
                              title: "Open the library of stories and\nlullabies.Press here",
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              titleColor: whiteColor.withOpacity(0.8),
                            ),
                            Container(
                              height: 57,
                              width: 57,
                              decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              padding: EdgeInsets.all(13),
                              child: PublicImage(
                                image: "assets/icons/cart.png",
                                color: whiteColor,
                                height: 1,
                                width: 1,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ...List.generate(storiesItems.length, (index) {
                      return StoriesWidget(
                        image: "${storiesItems[index]["image"]}",
                        title: "${storiesItems[index]["title"]}",
                        clock: "${storiesItems[index]["clock"]}",
                        time: "${storiesItems[index]["time"]}",
                        playButton: "${storiesItems[index]["playButton"]}",
                        playButtonColor: index!=0&&index!=1?whiteColor.withOpacity(0.3):yellowColor,
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({
    super.key,
    required this.image,
    required this.playButton,
    required this.clock,
    required this.title,
    required this.time,
    required this.playButtonColor,
  });
  final String image;
  final String playButton;
  final String clock;
  final String title;
  final Color playButtonColor;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height:108,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                image,
                width: 75,
                fit: BoxFit.cover,
                height: 85,
              ),
            ),
            SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PublicText(
                    title: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    titleColor: whiteColor.withOpacity(0.9),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PublicImage(
                        image: clock,
                        height: 15,
                        color: whiteColor.withOpacity(0.8),
                        width: 15,
                        fit: BoxFit.contain,
                      ),
                      Sbw(width: 0.04,),
                      PublicText(
                        title: time,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        titleColor: whiteColor.withOpacity(0.8),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 57,
              width: 57,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: whiteColor.withOpacity(0.3),
                    width: 1.2
                  )
              ),
              alignment: Alignment.center,
              // padding: EdgeInsets.all(15),
              child: Center(
                child: PublicImage(
                  image: playButton,
                  color: playButtonColor,
                  height: 23,
                  width: 23,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key, required this.image, required this.height, required this.width, required this.onTap,
  });
  final String image;
  final double height;
  final double width;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90)
        ),
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: PublicImage(image: image,color: yellowColor,height: 22,
        width: 22,),
      ),
    );
  }
}

class PublicImage extends StatelessWidget {
  const PublicImage({
    super.key,
    required this.image,
    this.height=1,
    this.width=1,
    this.color=mainColor,
    this.fit=BoxFit.contain
  });

  final String image;
  final double height;
  final double width;
  final Color color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      color: color,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
