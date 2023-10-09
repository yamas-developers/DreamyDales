import 'package:flutter/cupertino.dart';
import 'package:subtitle/subtitle.dart';

class SubtitlesProvider extends ChangeNotifier{
  Duration _currentPosition = Duration.zero;

  Duration get currentPosition => _currentPosition;

  set currentPosition(Duration value) {
    _currentPosition = value;
    notifyListeners();
  }

  List<Subtitle> parseSrt(String srtContent) {
    List<Subtitle> parsedSubtitles = [];
    List<String> lines = srtContent.split('\n');

    // Temporary variables to store subtitle data
    int index = 0;
    Duration? startTime;
    Duration? endTime;
    String data = '';

    for (String line in lines) {
      line = line.trim();

      if (line.isEmpty) {
        // Empty line indicates the end of a subtitle block
        if (index != 0 &&
            startTime != null &&
            endTime != null &&
            data.isNotEmpty) {
          Subtitle subtitle = Subtitle(
              index: index, start: startTime, end: endTime, data: data);
          parsedSubtitles.add(subtitle);
        }

        // Reset temporary variables for the next subtitle block
        index = 0;
        startTime = null;
        endTime = null;
        data = '';
      } else if (index == 0) {
        // First line of the subtitle block contains the index
        index = int.tryParse(line) ?? 0;
      } else if (startTime == null) {
        // Second line contains the start and end times
        List<String> times = line.split(' --> ');
        if (times.length == 2) {
          String start = times[0];
          String end = times[1];

          startTime = parseSrtTimeToDuration(start);
          endTime = parseSrtTimeToDuration(end);
        }
      } else {
        // Remaining lines contain subtitle data
        if (data.isEmpty) {
          data = line;
        } else {
          data += '\n$line';
        }
      }
    }

    // Add the last subtitle block if it has valid data
    if (index != 0 && startTime != null && endTime != null && data.isNotEmpty) {
      Subtitle subtitle =
      Subtitle(index: index, start: startTime, end: endTime, data: data);
      parsedSubtitles.add(subtitle);
    }

    return parsedSubtitles;
  }


  Duration parseSrtTimeToDuration(String srtTime) {
    // Split the time string into hours, minutes, seconds, and milliseconds parts
    List<String> parts = srtTime.split(':');
    List<String> secondsAndMilliseconds = parts[2].split(',');

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(secondsAndMilliseconds[0]);
    int milliseconds = int.parse(secondsAndMilliseconds[1]);

    // Calculate the total milliseconds
    int totalMilliseconds =
        (hours * 3600000) + (minutes * 60000) + (seconds * 1000) + milliseconds;

    return Duration(milliseconds: totalMilliseconds);
  }
}