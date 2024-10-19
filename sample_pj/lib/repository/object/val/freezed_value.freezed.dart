// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezedValue _$FreezedValueFromJson(Map<String, dynamic> json) {
  return _FreezedValue.fromJson(json);
}

/// @nodoc
mixin _$FreezedValue {
  int get value => throw _privateConstructorUsedError;

  /// Serializes this FreezedValue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FreezedValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FreezedValueCopyWith<FreezedValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedValueCopyWith<$Res> {
  factory $FreezedValueCopyWith(
          FreezedValue value, $Res Function(FreezedValue) then) =
      _$FreezedValueCopyWithImpl<$Res, FreezedValue>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$FreezedValueCopyWithImpl<$Res, $Val extends FreezedValue>
    implements $FreezedValueCopyWith<$Res> {
  _$FreezedValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FreezedValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedValueImplCopyWith<$Res>
    implements $FreezedValueCopyWith<$Res> {
  factory _$$FreezedValueImplCopyWith(
          _$FreezedValueImpl value, $Res Function(_$FreezedValueImpl) then) =
      __$$FreezedValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$FreezedValueImplCopyWithImpl<$Res>
    extends _$FreezedValueCopyWithImpl<$Res, _$FreezedValueImpl>
    implements _$$FreezedValueImplCopyWith<$Res> {
  __$$FreezedValueImplCopyWithImpl(
      _$FreezedValueImpl _value, $Res Function(_$FreezedValueImpl) _then)
      : super(_value, _then);

  /// Create a copy of FreezedValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$FreezedValueImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedValueImpl extends _FreezedValue {
  const _$FreezedValueImpl({required this.value}) : super._();

  factory _$FreezedValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedValueImplFromJson(json);

  @override
  final int value;

  @override
  String toString() {
    return 'FreezedValue(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of FreezedValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedValueImplCopyWith<_$FreezedValueImpl> get copyWith =>
      __$$FreezedValueImplCopyWithImpl<_$FreezedValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedValueImplToJson(
      this,
    );
  }
}

abstract class _FreezedValue extends FreezedValue {
  const factory _FreezedValue({required final int value}) = _$FreezedValueImpl;
  const _FreezedValue._() : super._();

  factory _FreezedValue.fromJson(Map<String, dynamic> json) =
      _$FreezedValueImpl.fromJson;

  @override
  int get value;

  /// Create a copy of FreezedValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FreezedValueImplCopyWith<_$FreezedValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
