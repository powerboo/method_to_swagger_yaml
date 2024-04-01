enum PictureKind {
  original(0),
  thumbnail(1);

  final int toInt;
  const PictureKind(this.toInt);
  factory PictureKind.from({
    required int value,
  }) {
    final indexEnum = PictureKind.values.firstWhere((e) => e.toInt == value);
    return indexEnum;
  }
}
