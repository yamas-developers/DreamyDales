import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/public_methods.dart';
import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Story {
  int id = 0;
  String? image;
  String? title;
  String? trackName;
  int? durationInMinutes;
  bool? isPremium;

  Story(
      {required this.id,
      this.image,
      this.title,
      this.trackName,
      this.durationInMinutes,
      this.isPremium});
}

class _HomeScreenState extends State<HomeScreen> {
  List<Story> stories = [
    Story(
      id: 1,
      image: "assets/images/cat_reading_book.png",
      title: "The Cat Does Not Sleep",
      trackName: 'story1.mp3',
      durationInMinutes: 20,
      isPremium: false,
    ),

    Story(
      id: 2,
      image: "assets/images/moon_in_night.png",
      title: "Gift for the Moon",
      trackName: 'story2.mp3',
      durationInMinutes: 11,
      isPremium: false,
    ),
    Story(
      id: 3,
      image: "assets/images/girl_doing_magic.png",
      title: "Believing in Magic",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 9,
      isPremium: true,
    ),
    Story(
      id: 4,
      image: "assets/images/candy_land.png",
      title: "Candy Land",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 20,
      isPremium: true,
    ),
    Story(
      id: 5,
      image: "assets/images/moon_in_night.png",
      title: "Find your Rainbow",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 16,
      isPremium: true,
    ),
    Story(
      id: 1,
      image: "assets/images/cat_reading_book.png",
      title: "Believe in your dream",
      trackName: 'story1.mp3',
      durationInMinutes: 20,
      isPremium: true,
    ),

  ];
  int playingId = 0;
  int loadedTrack = 0;
  Duration position = Duration.zero;
  bool isAudioPlaying = false;
  Duration duration = Duration.zero;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isAudioPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 5,
        title: PublicText(
          title: "Bedtime Stories",
          fontSize: 23,
          fontWeight: FontWeight.w500,
          titleColor: whiteColor,
        ),
        actions: [
          AppBarWidget(
            // image: "assets/icons/music_library.png",
            icon: Icons.queue_music,
            height: 22,
            width: 22,
            onTap: () {},
          ),
          AppBarWidget(
            // icon: "assets/icons/internet.png",
            icon: Icons.language,
            height: 22,
            width: 22,
            onTap: () {},
          ),
          AppBarWidget(
            // icon: "assets/icons/setting.png",
            icon: Icons.settings_outlined,
            height: 22,
            width: 22,
            onTap: () {
              Navigator.pushNamed(context, "settingsScreen");
            },
          ),
          const Sbw(
            width: 0.02,
          )
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
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Open the library of bedtime stories. Press here",
                                style: TextStyle(
                                  fontSize: 19,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w400,
                                  color: whiteColor.withOpacity(1),
                                ),
                              ),
                            ),
                            Container(
                              // height: 57,
                              // width: 57,
                              decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(50)),
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.shopping_cart_checkout_outlined,
                                size: 36,
                                color: whiteColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ...List.generate(stories.length, (index) {
                      return StoriesWidget(
                        playing: playingId == stories[index].id,
                        isTrackLoaded: loadedTrack == stories[index].id,
                        onTap: () async {
                          if(stories[index].isPremium == true){
                            return;
                          }
                          if (playingId == stories[index].id) {
                            await audioPlayer.pause();
                            setState(() {
                              playingId = 0;
                            });
                          } else {
                            setState(() {
                              playingId = stories[index].id;
                              loadedTrack = stories[index].id;
                            });
                            await audioPlayer.play(AssetSource(
                                'audios/${stories[index].trackName}'));
                          }
                        },
                        story: stories[index],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: SliderTheme(
                            data: SliderThemeData(
                                trackShape: CustomTrackShape(),
                                thumbShape:
                                    RoundSliderThumbShape(enabledThumbRadius: 7),
                                trackHeight: 1.8,
                                activeTrackColor: accentColor,
                                inactiveTrackColor: whiteColor.withOpacity(0.5),
                                thumbColor: accentColor),
                            child: Slider(

                              min: 0,
                              value: position.inSeconds.toDouble(),
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final position = Duration(seconds: value.toInt());
                                await audioPlayer.seek(position);
                                await audioPlayer.resume();
                                log('MK: onchanged: ');
                                setState(() {
                                  playingId = stories[index].id;
                                  loadedTrack = stories[index].id;
                                });
                              },
                            ),
                          ),
                        ),
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
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class StoriesWidget extends StatelessWidget {
  const StoriesWidget(
      {super.key,
      this.playing = false,
      required this.onTap,
      required this.child,
      required this.story,
      this.isTrackLoaded = false});

  final Story story;

  final bool playing;
  final bool isTrackLoaded;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // height: height,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: blueColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  '${story.image}',
                  width: 85,
                  fit: BoxFit.cover,
                  height: 95,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${story.title ?? '--'}',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: whiteColor.withOpacity(0.8),
                              )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: whiteColor.withOpacity(0.9),
                          size: 19,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        PublicText(
                          title: '${story.durationInMinutes ?? '--'} mins.',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          titleColor: whiteColor.withOpacity(0.8),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: whiteColor.withOpacity(0.3), width: 1.2)),
                alignment: Alignment.center,
                // padding: EdgeInsets.all(15),
                child: Center(
                  child: GestureDetector(
                    onTap: onTap,
                    child: story.isPremium == true
                        ? Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.lock,
                              color: whiteColor.withOpacity(0.3),
                              size: 26,
                            ),
                          )
                        : Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            color: accentColor,
                            size: 44,
                            // height: 26,
                            // width: 23,
                            // fit: BoxFit.contain,
                          ),
                  ),
                ),
              )
            ],
          ),
          isTrackLoaded ? Container(height: 55, child: child) : const SizedBox()
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
    required this.onTap,
  });

  final IconData icon;
  final double height;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          icon,
          color: accentColor,
          size: 30,
        ),
      ),
    );
  }
}

class PublicImage extends StatelessWidget {
  const PublicImage(
      {super.key,
      required this.image,
      this.height = 1,
      this.width = 1,
      this.color = mainColor,
      this.fit = BoxFit.contain});

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
