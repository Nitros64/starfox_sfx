class Voice {
  late String? title;
  late String path;
  late int? millis;

  Voice({required this.title, required this.path, required this.millis});
  factory Voice.fromJson(Map<String, dynamic> json) {
    return Voice(
      title: json['title'],
      path: json['path'],
      millis: json['millis'],
    );
  }
}
