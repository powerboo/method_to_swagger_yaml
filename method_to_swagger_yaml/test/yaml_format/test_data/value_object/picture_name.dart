import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_name.g.dart';

@JsonSerializable()
class PictureName {
  @JsonKey(name: 'picture_name')
  final String value;

  PictureName(this.value) {
    if (value.isEmpty) {
      throw PictureNameException("PictureName does not empty.");
    }
  }

  factory PictureName.fromJson(Map<String, Object?> json) =>
      _$PictureNameFromJson(json);

  Map<String, Object?> toJson() => _$PictureNameToJson(this);

  @override
  String toString() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is PictureName && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class PictureNameException implements Exception {
  late final String message;
  PictureNameException(final String message) {
    this.message = "[PictureNameException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
