import 'package:audioplayers/audioplayers.dart';
import 'package:bedtime_stories/ui/home_screen/subtitle_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:subtitle/subtitle.dart';

import '../../common_widgets/public_methods.dart';
import '../../constants.dart';
import '../../providers/subtitle_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Story {
  int id = 0;
  String? image;
  String? title;
  String? subTitle;
  String? trackName;
  int? durationInMinutes;
  bool? isPremium;

  Story(
      {required this.id,
      this.image,
      this.title,
      this.subTitle,
      this.trackName,
      this.durationInMinutes,
      this.isPremium});
}

class _HomeScreenState extends State<HomeScreen> {
  List<Story> stories = [
    Story(
      id: 1,
      image: "assets/images/cat_reading_book.png",
      title: "BedTimeStories__catDoesNotSleep",
      subTitle: "story1.srt",
      trackName: 'story1.mp3',
      durationInMinutes: 20,
      isPremium: false,
    ),
    Story(
      id: 2,
      image: "assets/images/moon_in_night.png",
      title: "BedTimeStories__giftForTheMoon",
      subTitle: "story2.srt",
      trackName: 'story2.mp3',
      durationInMinutes: 11,
      isPremium: false,
    ),
    Story(
      id: 3,
      image: "assets/images/girl_doing_magic.png",
      title: "BedTimeStories__believingInMagic",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 9,
      isPremium: true,
    ),
    Story(
      id: 4,
      image: "assets/images/candy_land.png",
      title: "BedTimeStories__candyLand",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 20,
      isPremium: true,
    ),
    Story(
      id: 5,
      image: "assets/images/moon_in_night.png",
      title: "BedTimeStories__findYourRainbow",
      trackName: 'tera_zikr.mp3',
      durationInMinutes: 16,
      isPremium: true,
    ),
    Story(
      id: 1,
      image: "assets/images/cat_reading_book.png",
      title: "BedTimeStories__believeInYourDream",
      trackName: 'story1.mp3',
      durationInMinutes: 20,
      isPremium: true,
    ),
  ];

  int playingId = 0;
  int loadedTrack = 0;

  // Duration position = Duration.zero;
  bool isAudioPlaying = false;
  Duration duration = Duration.zero;
  final audioPlayer = AudioPlayer();
  List<Subtitle> subtitles = [];

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
      // setState(() {
      //   position = event;
      // });
      context.read<SubtitlesProvider>().currentPosition = Duration(seconds: event.inSeconds+0);
    });

    super.initState();
  }

  Future<void> loadSubtitles(String? path) async {
    if (path == null) {
      setState(() {
        subtitles = [];
      });
      return;
    }
    String subtitleContent =
        await rootBundle.loadString('assets/subtitles/$path');
    List<Subtitle> parsedSubtitles =
        context.read<SubtitlesProvider>().parseSrt(subtitleContent);
    setState(() {
      subtitles = parsedSubtitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 5,
        title: const Text(
          "Bedtime Stories",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
        ),
        actions: [
          AppBarWidget(
            // image: "assets/icons/music_library.png",
            icon: Icons.queue_music,
            height: 22,
            width: 22,
            onTap: () {
              showPaymentDialogue(context);
            },
          ),
          AppBarWidget(
            // icon: "assets/icons/internet.png",
            icon: Icons.language,
            height: 22,
            width: 22,
            onTap: () {
              showLanguageDialogue(context);
            },
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
      body: Consumer<SubtitlesProvider>(builder: (context, subPro, _) {
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
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
                      GestureDetector(
                        onTap: () {
                          showPaymentDialogue(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Open the library of bedtime stories. Press here",
                                    style: TextStyle(
                                      fontSize: 17,
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
                                  padding: const EdgeInsets.all(14),
                                  child: const Icon(
                                    Icons.shopping_cart_checkout_outlined,
                                    size: 28,
                                    color: whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ...List.generate(stories.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            if(loadedTrack == stories[index].id){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubtitleBox(
                                      subtitles: subtitles,
                                      currentPosition:
                                          subPro.currentPosition.inMilliseconds,
                                      currentDuration: duration.inMilliseconds,
                                    ),
                                  ));
                            }
                          },
                          child: StoriesWidget(
                            playing: playingId == stories[index].id,
                            isTrackLoaded: loadedTrack == stories[index].id,
                            onTap: () async {
                              if (stories[index].isPremium == true) {
                                showPaymentDialogue(context);
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
                                loadSubtitles(stories[index].subTitle);
                                await audioPlayer.play(AssetSource(
                                    'audios/${stories[index].trackName}'));
                              }
                            },
                            story: stories[index],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                children: [
                                  // Text(
                                  //   '${position}',
                                  //   style: TextStyle(color: accentColor),
                                  // ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                        trackShape: CustomTrackShape(),
                                        thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 7),
                                        trackHeight: 1.8,
                                        activeTrackColor: accentColor,
                                        inactiveTrackColor:
                                            whiteColor.withOpacity(0.5),
                                        thumbColor: accentColor),
                                    child: Slider(
                                      min: 0,
                                      value: subPro.currentPosition.inSeconds
                                          .toDouble(),
                                      max: duration.inSeconds.toDouble(),
                                      onChanged: (value) async {
                                        final position =
                                            Duration(seconds: value.toInt());
                                        await audioPlayer.seek(position);
                                        await audioPlayer.resume();
                                        setState(() {
                                          playingId = stories[index].id;
                                          loadedTrack = stories[index].id;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    '${findSubtitleForPosition().data}',
                                    style: TextStyle(
                                        color: accentColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ],
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
        );
      }),
    );
  }

  Subtitle findSubtitleForPosition() {
    Duration pos = Duration(
        seconds: context.read<SubtitlesProvider>().currentPosition.inSeconds);
    return subtitles.firstWhere(
      (subtitle) => pos >= subtitle.start && pos <= subtitle.end,
      orElse: () => Subtitle(
          start: Duration.zero, end: Duration.zero, data: '', index: 0),
    );
  }
}

void showLanguageDialogue(BuildContext context) {
  showAlertDialog(
    context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: PublicText(
              title: "Voice Language",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              titleColor: blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        color: blackColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                const Sbw(
                  width: 0.04,
                ),
                GestureDetector(
                  onTap: () async {
                    context.setLocale(
                      const Locale('fr', 'FR'),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "PYCCKNN",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    context.setLocale(
                      const Locale('en', 'US'),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "ENGLISH",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

void showPaymentDialogue(BuildContext context) {
  List<String> storiesLibraryItems = [
    "500+min.of_content",
    "100% Kid-safe",
    "Calm and sleep",
    "Playlist editing",
    "Lifetime access",
  ];
  showAlertDialog(
    context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 14),
            child: PublicText(
              title: "Help Your Child Fall Asleep",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              titleColor: blackColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: PublicText(
              title: "Open the entire library. You pay only\nonce!",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              titleColor: blackColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ...List.generate(storiesLibraryItems.length, (index) {
            return StoryLibraryItem(
              title: " ${storiesLibraryItems[index]}",
            );
          }),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: mainColor))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        color: blackColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // openNetworkSettings();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "BUY RS 499.00",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
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
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: blueColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  '${story.image}',
                  width: 80,
                  fit: BoxFit.cover,
                  height: 85,
                ),
              ),
              const SizedBox(
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
                          Text(story.title ?? '--',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: whiteColor.withOpacity(0.8),
                              )).tr(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: whiteColor.withOpacity(0.9),
                          size: 17,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PublicText(
                          title: '${story.durationInMinutes ?? '--'} mins.',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          titleColor: whiteColor.withOpacity(0.8),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(4),
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
                              size: 24,
                            ),
                          )
                        : Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            color: accentColor,
                            size: 40,
                            // height: 26,
                            // width: 23,
                            // fit: BoxFit.contain,
                          ),
                  ),
                ),
              )
            ],
          ),
          isTrackLoaded
              ? SizedBox(
                  // height: 55,
                  child: child,
                )
              : const SizedBox()
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

class StoryLibraryItem extends StatelessWidget {
  const StoryLibraryItem({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/icons/star.png",
          fit: BoxFit.contain,
          height: 20,
          width: 20,
        ),
        const Sbw(
          width: 0.005,
        ),
        PublicText(
          title: title,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          titleColor: blackColor,
        ),
      ],
    );
  }
}
