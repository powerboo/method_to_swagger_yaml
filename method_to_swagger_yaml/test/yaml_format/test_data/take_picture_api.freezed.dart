// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'take_picture_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TargetPicture _$TargetPictureFromJson(Map<String, dynamic> json) {
  return _TargetPicture.fromJson(json);
}

/// @nodoc
mixin _$TargetPicture {
  PictureId get pictureId => throw _privateConstructorUsedError;
  PictureName get pictureName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TargetPictureCopyWith<TargetPicture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetPictureCopyWith<$Res> {
  factory $TargetPictureCopyWith(
          TargetPicture value, $Res Function(TargetPicture) then) =
      _$TargetPictureCopyWithImpl<$Res, TargetPicture>;
  @useResult
  $Res call({PictureId pictureId, PictureName pictureName});
}

/// @nodoc
class _$TargetPictureCopyWithImpl<$Res, $Val extends TargetPicture>
    implements $TargetPictureCopyWith<$Res> {
  _$TargetPictureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pictureId = null,
    Object? pictureName = null,
  }) {
    return _then(_value.copyWith(
      pictureId: null == pictureId
          ? _value.pictureId
          : pictureId // ignore: cast_nullable_to_non_nullable
              as PictureId,
      pictureName: null == pictureName
          ? _value.pictureName
          : pictureName // ignore: cast_nullable_to_non_nullable
              as PictureName,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetPictureImplCopyWith<$Res>
    implements $TargetPictureCopyWith<$Res> {
  factory _$$TargetPictureImplCopyWith(
          _$TargetPictureImpl value, $Res Function(_$TargetPictureImpl) then) =
      __$$TargetPictureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PictureId pictureId, PictureName pictureName});
}

/// @nodoc
class __$$TargetPictureImplCopyWithImpl<$Res>
    extends _$TargetPictureCopyWithImpl<$Res, _$TargetPictureImpl>
    implements _$$TargetPictureImplCopyWith<$Res> {
  __$$TargetPictureImplCopyWithImpl(
      _$TargetPictureImpl _value, $Res Function(_$TargetPictureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pictureId = null,
    Object? pictureName = null,
  }) {
    return _then(_$TargetPictureImpl(
      pictureId: null == pictureId
          ? _value.pictureId
          : pictureId // ignore: cast_nullable_to_non_nullable
              as PictureId,
      pictureName: null == pictureName
          ? _value.pictureName
          : pictureName // ignore: cast_nullable_to_non_nullable
              as PictureName,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetPictureImpl extends _TargetPicture {
  const _$TargetPictureImpl(
      {required this.pictureId, required this.pictureName})
      : super._();

  factory _$TargetPictureImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetPictureImplFromJson(json);

  @override
  final PictureId pictureId;
  @override
  final PictureName pictureName;

  @override
  String toString() {
    return 'TargetPicture(pictureId: $pictureId, pictureName: $pictureName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetPictureImpl &&
            (identical(other.pictureId, pictureId) ||
                other.pictureId == pictureId) &&
            (identical(other.pictureName, pictureName) ||
                other.pictureName == pictureName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pictureId, pictureName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetPictureImplCopyWith<_$TargetPictureImpl> get copyWith =>
      __$$TargetPictureImplCopyWithImpl<_$TargetPictureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetPictureImplToJson(
      this,
    );
  }
}

abstract class _TargetPicture extends TargetPicture {
  const factory _TargetPicture(
      {required final PictureId pictureId,
      required final PictureName pictureName}) = _$TargetPictureImpl;
  const _TargetPicture._() : super._();

  factory _TargetPicture.fromJson(Map<String, dynamic> json) =
      _$TargetPictureImpl.fromJson;

  @override
  PictureId get pictureId;
  @override
  PictureName get pictureName;
  @override
  @JsonKey(ignore: true)
  _$$TargetPictureImplCopyWith<_$TargetPictureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
