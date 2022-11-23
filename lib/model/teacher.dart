class Teacher {
  Teacher({
    required this.name,
    required this.nation,
    required this.rating,
    required this.tags,
    required this.decription,
    required this.avatarUrl,
    // required this.videoDescriptionUrl,
    // required this.language
  });
  String name;
  Nation nation;
  double rating;
  List<String> tags;
  String decription;
  String avatarUrl;
  // String videoDescriptionUrl;
  // String language;
}

class Nation {
  Nation({
    required this.name,
    required this.flagUrl,
  });
  String name;
  String flagUrl;
}
