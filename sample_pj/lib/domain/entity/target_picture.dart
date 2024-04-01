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
