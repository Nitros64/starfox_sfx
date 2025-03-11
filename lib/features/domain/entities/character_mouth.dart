class CharacterMouth {
  final int left;
  final int top;
  final int width;
  final int height;

  CharacterMouth({required this.left, required this.top, required this.width, required this.height});

  factory CharacterMouth.fromJson(Map<String, dynamic> json) {
    return CharacterMouth(
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
    );
  }
}