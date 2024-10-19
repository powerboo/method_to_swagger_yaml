// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezedId _$FreezedIdFromJson(Map<String, dynamic> json) {
  return _FreezedId.fromJson(json);
}

/// @nodoc
mixin _$FreezedId {
  String get freezedId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezedIdCopyWith<FreezedId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedIdCopyWith<$Res> {
  factory $FreezedIdCopyWith(FreezedId value, $Res Function(FreezedId) then) =
      _$FreezedIdCopyWithImpl<$Res, FreezedId>;
  @useResult
  $Res call({String freezedId});
}

/// @nodoc
class _$FreezedIdCopyWithImpl<$Res, $Val extends FreezedId>
    implements $FreezedIdCopyWith<$Res> {
  _$FreezedIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freezedId = null,
  }) {
    return _then(_value.copyWith(
      freezedId: null == freezedId
          ? _value.freezedId
          : freezedId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedIdImplCopyWith<$Res>
    implements $FreezedIdCopyWith<$Res> {
  factory _$$FreezedIdImplCopyWith(
          _$FreezedIdImpl value, $Res Function(_$FreezedIdImpl) then) =
      __$$FreezedIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String freezedId});
}

/// @nodoc
class __$$FreezedIdImplCopyWithImpl<$Res>
    extends _$FreezedIdCopyWithImpl<$Res, _$FreezedIdImpl>
    implements _$$FreezedIdImplCopyWith<$Res> {
  __$$FreezedIdImplCopyWithImpl(
      _$FreezedIdImpl _value, $Res Function(_$FreezedIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freezedId = null,
  }) {
    return _then(_$FreezedIdImpl(
      freezedId: null == freezedId
          ? _value.freezedId
          : freezedId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedIdImpl extends _FreezedId {
  const _$FreezedIdImpl({required this.freezedId}) : super._();

  factory _$FreezedIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedIdImplFromJson(json);

  @override
  final String freezedId;

  @override
  String toString() {
    return 'FreezedId(freezedId: $freezedId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedIdImpl &&
            (identical(other.freezedId, freezedId) ||
                other.freezedId == freezedId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, freezedId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedIdImplCopyWith<_$FreezedIdImpl> get copyWith =>
      __$$FreezedIdImplCopyWithImpl<_$FreezedIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedIdImplToJson(
      this,
    );
  }
}

abstract class _FreezedId extends FreezedId {
  const factory _FreezedId({required final String freezedId}) = _$FreezedIdImpl;
  const _FreezedId._() : super._();

  factory _FreezedId.fromJson(Map<String, dynamic> json) =
      _$FreezedIdImpl.fromJson;

  @override
  String get freezedId;
  @override
  @JsonKey(ignore: true)
  _$$FreezedIdImplCopyWith<_$FreezedIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
