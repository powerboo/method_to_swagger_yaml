// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureId _$PictureIdFromJson(Map<String, dynamic> json) => PictureId(
      value: json['picture_id'] as String,
      pictureKind: $enumDecode(_$PictureKindEnumMap, json['picture_kind']),
    );

Map<String, dynamic> _$PictureIdToJson(PictureId instance) => <String, dynamic>{
      'picture_id': instance.value,
      'picture_kind': _$PictureKindEnumMap[instance.pictureKind]!,
    };

const _$PictureKindEnumMap = {
  PictureKind.original: 'original',
  PictureKind.thumbnail: 'thumbnail',
};

PictureName _$PictureNameFromJson(Map<String, dynamic> json) => PictureName(
      json['picture_name'] as String,
    );

Map<String, dynamic> _$PictureNameToJson(PictureName instance) =>
    <String, dynamic>{
      'picture_name': instance.value,
    };

_$TargetPictureImpl _$$TargetPictureImplFromJson(Map<String, dynamic> json) =>
    _$TargetPictureImpl(
      pictureId: PictureId.fromJson(json['pictureId'] as Map<String, dynamic>),
      pictureName:
          PictureName.fromJson(json['pictureName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TargetPictureImplToJson(_$TargetPictureImpl instance) =>
    <String, dynamic>{
      'pictureId': instance.pictureId,
      'pictureName': instance.pictureName,
    };
