import 'package:bedtime_stories/providers/favorite_provider.dart';
import 'package:bedtime_stories/providers/subtitle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtitle/subtitle.dart';

import '../../constants.dart';

class SubtitleBox extends StatefulWidget {
  final List<Subtitle> subtitles;
  final int currentPosition;
  final int currentDuration;
  final int storyId;

  SubtitleBox({
    super.key,
    required this.subtitles,
    required this.currentPosition,
    required this.currentDuration,
    required this.storyId,
  });

  @override
  _SubtitleBoxState createState() => _SubtitleBoxState();
}

class _SubtitleBoxState extends State<SubtitleBox> {
  ScrollController _scrollController = ScrollController();
  Subtitle? _currentSubtitle;

  @override
  void didUpdateWidget(SubtitleBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToCurrentSubtitle();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _currentSubtitle = _getCurrentSubtitle(
          context.read<SubtitlesProvider>().currentPosition.inMilliseconds);
      if (_currentSubtitle != null) {
        int subtitleIndex = widget.subtitles.indexOf(_currentSubtitle!);
        if (subtitleIndex > 4) {
          double scrollOffset =
              subtitleIndex * (50); // Adjust based on itemExtent
          if (scrollOffset < 300) return;
          // print("scrollOffset: ${'f'}" + scrollOffset.toString());
          _scrollController.animateTo(
            scrollOffset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
    super.initState();
  }

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
        builder: (context, FavoritesProvider favPro, _) {
      bool isFavorite = favPro.favorites.contains(widget.storyId);
      return Scaffold(
        // backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 5,
          foregroundColor: whiteColor,
          title: const Text(
            "Story Lyrics",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (isFavorite) {
                    favPro.removeFavorite(widget.storyId);
                  } else {
                    favPro.addFavorite(widget.storyId);
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border_outlined,
                  color: isFavorite ? accentColor : whiteColor,
                  size: 30,
                )),
          ],
        ),
        body: Consumer<SubtitlesProvider>(builder: (context, subPro, _) {
          _currentSubtitle =
              _getCurrentSubtitle(subPro.currentPosition.inMilliseconds);
          // _scrollToCurrentSubtitle();
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: widget.subtitles.length,
                          // itemExtent: 80, // Adjust the item extent as per your requirements
                          itemBuilder: (context, index) {
                            final subtitle = widget.subtitles[index];
                            return Text(
                              subtitle.data,
                              key: GlobalObjectKey(subtitle.index),
                              // key: subtitle == _currentSubtitle ? key : null,
                              style: TextStyle(
                                fontSize:
                                    subtitle == _currentSubtitle ? 34 : 24,
                                fontWeight: subtitle == _currentSubtitle
                                    ? FontWeight.w900
                                    : FontWeight.w500,
                                color: subtitle == _currentSubtitle
                                    ? accentColor
                                    : whiteColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      );
    });
  }

  void _scrollToCurrentSubtitle() {
    if (GlobalObjectKey(_currentSubtitle?.index ?? 0).currentContext != null) {
      int subtitleIndex = widget.subtitles.indexOf(_currentSubtitle!);
      if (subtitleIndex > 4) {
        // Scrollable.ensureVisible(GlobalObjectKey(category?.id).currentContext);
        Scrollable.ensureVisible(
            GlobalObjectKey(_currentSubtitle?.index ?? 0).currentContext!,
            duration: Duration(milliseconds: 500),
            // duration for scrolling time
            alignment: .5,
            // 0 mean, scroll to the top, 0.5 mean, half
            curve: Curves.easeInOutCubic);
        //   double scrollOffset = subtitleIndex * 70; // Adjust based on itemExtent
        //   if(scrollOffset < 300)return;
        //   print("scrollOffset: ${'f'}" + scrollOffset.toString());
        //   _scrollController.animateTo(
        //     scrollOffset,
        //     duration: const Duration(milliseconds: 300),
        //     curve: Curves.easeInOut,
        //   );
      }
    }
  }

  Subtitle? _getCurrentSubtitle(int currentPosition) {
    for (int i = 0; i < widget.subtitles.length; i++) {
      if (currentPosition >= widget.subtitles[i].start.inMilliseconds &&
          currentPosition <= widget.subtitles[i].end.inMilliseconds) {
        _scrollToCurrentSubtitle();
        return widget.subtitles[i];
      }
    }
    return null;
  }
}
