// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
