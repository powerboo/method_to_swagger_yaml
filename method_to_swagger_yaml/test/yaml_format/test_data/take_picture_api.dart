import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

import 'value_object/picture_id.dart';

part 'take_picture_api.g.dart';
part 'take_picture_api.freezed.dart';

@ConvertTargetClass(
  title: "title",
  version: "0.0.1",
)
abstract interface class TargetPictureApi {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "target-picture/:pictureId",
  )
  Future<TargetPicture?> find(
      {@RequestParameter(
        requestParameterDiv: RequestParameterDiv.path,
      )
      required PictureId pictureId});

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "target-picture",
  )
  Future<List<TargetPicture>> all({
    int cursor = 0,
    int length = 100,
  });

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.post,
    pathName: "target-picture",
  )
  Future<void> save({required TargetPicture targetPicture});

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.delete,
    pathName: "target-picture/:pictureId",
  )
  Future<void> delete({required PictureId pictureId});
}

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
      throw Exception("PictureName does not empty.");
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
  original,
  thumbnail;
}
