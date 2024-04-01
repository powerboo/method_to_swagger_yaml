import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_object/picture_id.dart';
import '../value_object/picture_name.dart';

part 'target_picture.freezed.dart';
part 'target_picture.g.dart';

@freezed
class TargetPicture with _$TargetPicture {
  const TargetPicture._();
  const factory TargetPicture({
    required PictureId pictureId,
    required PictureName pictureName,
  }) = _TargetPicture;
  factory TargetPicture.fromJson(Map<String, Object?> json) =>
      _$TargetPictureFromJson(json);
}

class TargetPictureException implements Exception {
  late final String message;
  TargetPictureException(final String message) {
    this.message = "[TargetPictureException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

@JsonSerializable()
class PictureId {
  @JsonKey(name: 'picture_id')
  final String value;

  @JsonKey(name: 'picture_kind')
  final PictureKind pictureKind;

  PictureId({
    required this.value,
    required this.pictureKind,
  }) {
    if (value.isEmpty) {
      throw PictureIdException("PictureId does not empty.");
    }
  }

  factory PictureId.fromJson(Map<String, Object?> json) =>
      _$PictureIdFromJson(json);

  Map<String, Object?> toJson() => _$PictureIdToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is PictureId &&
          other.value == value &&
          other.pictureKind == pictureKind);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

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
