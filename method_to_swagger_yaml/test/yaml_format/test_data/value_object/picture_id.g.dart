// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_id.dart';

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
