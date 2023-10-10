import 'package:flutter/cupertino.dart';

import '../models/story.dart';

class StoryProvider extends ChangeNotifier{
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
      id: 7,
      image: "assets/images/cat_reading_book.png",
      title: "BedTimeStories__believeInYourDream",
      trackName: 'story1.mp3',
      durationInMinutes: 20,
      isPremium: true,
    ),
  ];
}