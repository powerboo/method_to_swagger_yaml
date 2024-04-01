import 'package:freezed_annotation/freezed_annotation.dart';

import 'picture_kind.dart';

part 'picture_id.g.dart';

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

class PictureIdException implements Exception {
  late final String message;
  PictureIdException(final String message) {
    this.message = "[PictureIdException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
