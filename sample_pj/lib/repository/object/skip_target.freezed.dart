// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SkipTarget _$SkipTargetFromJson(Map<String, dynamic> json) {
  return _SkipTarget.fromJson(json);
}

/// @nodoc
mixin _$SkipTarget {
  String get skipTarget => throw _privateConstructorUsedError;
  @IgnoreField()
  String get ignoreTarget => throw _privateConstructorUsedError;

  /// Serializes this SkipTarget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkipTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkipTargetCopyWith<SkipTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkipTargetCopyWith<$Res> {
  factory $SkipTargetCopyWith(
          SkipTarget value, $Res Function(SkipTarget) then) =
      _$SkipTargetCopyWithImpl<$Res, SkipTarget>;
  @useResult
  $Res call({String skipTarget, @IgnoreField() String ignoreTarget});
}

/// @nodoc
class _$SkipTargetCopyWithImpl<$Res, $Val extends SkipTarget>
    implements $SkipTargetCopyWith<$Res> {
  _$SkipTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkipTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skipTarget = null,
    Object? ignoreTarget = null,
  }) {
    return _then(_value.copyWith(
      skipTarget: null == skipTarget
          ? _value.skipTarget
          : skipTarget // ignore: cast_nullable_to_non_nullable
              as String,
      ignoreTarget: null == ignoreTarget
          ? _value.ignoreTarget
          : ignoreTarget // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkipTargetImplCopyWith<$Res>
    implements $SkipTargetCopyWith<$Res> {
  factory _$$SkipTargetImplCopyWith(
          _$SkipTargetImpl value, $Res Function(_$SkipTargetImpl) then) =
      __$$SkipTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String skipTarget, @IgnoreField() String ignoreTarget});
}

/// @nodoc
class __$$SkipTargetImplCopyWithImpl<$Res>
    extends _$SkipTargetCopyWithImpl<$Res, _$SkipTargetImpl>
    implements _$$SkipTargetImplCopyWith<$Res> {
  __$$SkipTargetImplCopyWithImpl(
      _$SkipTargetImpl _value, $Res Function(_$SkipTargetImpl) _then)
      : super(_value, _then);

  /// Create a copy of SkipTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skipTarget = null,
    Object? ignoreTarget = null,
  }) {
    return _then(_$SkipTargetImpl(
      skipTarget: null == skipTarget
          ? _value.skipTarget
          : skipTarget // ignore: cast_nullable_to_non_nullable
              as String,
      ignoreTarget: null == ignoreTarget
          ? _value.ignoreTarget
          : ignoreTarget // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkipTargetImpl extends _SkipTarget {
  const _$SkipTargetImpl(
      {required this.skipTarget, @IgnoreField() required this.ignoreTarget})
      : super._();

  factory _$SkipTargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkipTargetImplFromJson(json);

  @override
  final String skipTarget;
  @override
  @IgnoreField()
  final String ignoreTarget;

  @override
  String toString() {
    return 'SkipTarget(skipTarget: $skipTarget, ignoreTarget: $ignoreTarget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkipTargetImpl &&
            (identical(other.skipTarget, skipTarget) ||
                other.skipTarget == skipTarget) &&
            (identical(other.ignoreTarget, ignoreTarget) ||
                other.ignoreTarget == ignoreTarget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, skipTarget, ignoreTarget);

  /// Create a copy of SkipTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkipTargetImplCopyWith<_$SkipTargetImpl> get copyWith =>
      __$$SkipTargetImplCopyWithImpl<_$SkipTargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkipTargetImplToJson(
      this,
    );
  }
}

abstract class _SkipTarget extends SkipTarget {
  const factory _SkipTarget(
      {required final String skipTarget,
      @IgnoreField() required final String ignoreTarget}) = _$SkipTargetImpl;
  const _SkipTarget._() : super._();

  factory _SkipTarget.fromJson(Map<String, dynamic> json) =
      _$SkipTargetImpl.fromJson;

  @override
  String get skipTarget;
  @override
  @IgnoreField()
  String get ignoreTarget;

  /// Create a copy of SkipTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkipTargetImplCopyWith<_$SkipTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
