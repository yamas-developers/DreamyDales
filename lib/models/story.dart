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