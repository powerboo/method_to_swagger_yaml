// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezedClass _$FreezedClassFromJson(Map<String, dynamic> json) {
  return _FreezedClass.fromJson(json);
}

/// @nodoc
mixin _$FreezedClass {
  FreezedId get freezedId => throw _privateConstructorUsedError;
  FreezedValue get freezedValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezedClassCopyWith<FreezedClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedClassCopyWith<$Res> {
  factory $FreezedClassCopyWith(
          FreezedClass value, $Res Function(FreezedClass) then) =
      _$FreezedClassCopyWithImpl<$Res, FreezedClass>;
  @useResult
  $Res call({FreezedId freezedId, FreezedValue freezedValue});

  $FreezedIdCopyWith<$Res> get freezedId;
  $FreezedValueCopyWith<$Res> get freezedValue;
}

/// @nodoc
class _$FreezedClassCopyWithImpl<$Res, $Val extends FreezedClass>
    implements $FreezedClassCopyWith<$Res> {
  _$FreezedClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freezedId = null,
    Object? freezedValue = null,
  }) {
    return _then(_value.copyWith(
      freezedId: null == freezedId
          ? _value.freezedId
          : freezedId // ignore: cast_nullable_to_non_nullable
              as FreezedId,
      freezedValue: null == freezedValue
          ? _value.freezedValue
          : freezedValue // ignore: cast_nullable_to_non_nullable
              as FreezedValue,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FreezedIdCopyWith<$Res> get freezedId {
    return $FreezedIdCopyWith<$Res>(_value.freezedId, (value) {
      return _then(_value.copyWith(freezedId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FreezedValueCopyWith<$Res> get freezedValue {
    return $FreezedValueCopyWith<$Res>(_value.freezedValue, (value) {
      return _then(_value.copyWith(freezedValue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FreezedClassImplCopyWith<$Res>
    implements $FreezedClassCopyWith<$Res> {
  factory _$$FreezedClassImplCopyWith(
          _$FreezedClassImpl value, $Res Function(_$FreezedClassImpl) then) =
      __$$FreezedClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FreezedId freezedId, FreezedValue freezedValue});

  @override
  $FreezedIdCopyWith<$Res> get freezedId;
  @override
  $FreezedValueCopyWith<$Res> get freezedValue;
}

/// @nodoc
class __$$FreezedClassImplCopyWithImpl<$Res>
    extends _$FreezedClassCopyWithImpl<$Res, _$FreezedClassImpl>
    implements _$$FreezedClassImplCopyWith<$Res> {
  __$$FreezedClassImplCopyWithImpl(
      _$FreezedClassImpl _value, $Res Function(_$FreezedClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freezedId = null,
    Object? freezedValue = null,
  }) {
    return _then(_$FreezedClassImpl(
      freezedId: null == freezedId
          ? _value.freezedId
          : freezedId // ignore: cast_nullable_to_non_nullable
              as FreezedId,
      freezedValue: null == freezedValue
          ? _value.freezedValue
          : freezedValue // ignore: cast_nullable_to_non_nullable
              as FreezedValue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedClassImpl extends _FreezedClass {
  const _$FreezedClassImpl(
      {required this.freezedId, required this.freezedValue})
      : super._();

  factory _$FreezedClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedClassImplFromJson(json);

  @override
  final FreezedId freezedId;
  @override
  final FreezedValue freezedValue;

  @override
  String toString() {
    return 'FreezedClass(freezedId: $freezedId, freezedValue: $freezedValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedClassImpl &&
            (identical(other.freezedId, freezedId) ||
                other.freezedId == freezedId) &&
            (identical(other.freezedValue, freezedValue) ||
                other.freezedValue == freezedValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, freezedId, freezedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedClassImplCopyWith<_$FreezedClassImpl> get copyWith =>
      __$$FreezedClassImplCopyWithImpl<_$FreezedClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedClassImplToJson(
      this,
    );
  }
}

abstract class _FreezedClass extends FreezedClass {
  const factory _FreezedClass(
      {required final FreezedId freezedId,
      required final FreezedValue freezedValue}) = _$FreezedClassImpl;
  const _FreezedClass._() : super._();

  factory _FreezedClass.fromJson(Map<String, dynamic> json) =
      _$FreezedClassImpl.fromJson;

  @override
  FreezedId get freezedId;
  @override
  FreezedValue get freezedValue;
  @override
  @JsonKey(ignore: true)
  _$$FreezedClassImplCopyWith<_$FreezedClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
