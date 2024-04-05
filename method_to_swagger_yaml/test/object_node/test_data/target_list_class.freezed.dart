// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_list_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TargetListClass {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ITargetListClass> get targetList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TargetListClassCopyWith<TargetListClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetListClassCopyWith<$Res> {
  factory $TargetListClassCopyWith(
          TargetListClass value, $Res Function(TargetListClass) then) =
      _$TargetListClassCopyWithImpl<$Res, TargetListClass>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<ITargetListClass> targetList});
}

/// @nodoc
class _$TargetListClassCopyWithImpl<$Res, $Val extends TargetListClass>
    implements $TargetListClassCopyWith<$Res> {
  _$TargetListClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? targetList = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetList: null == targetList
          ? _value.targetList
          : targetList // ignore: cast_nullable_to_non_nullable
              as List<ITargetListClass>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetListClassImplCopyWith<$Res>
    implements $TargetListClassCopyWith<$Res> {
  factory _$$TargetListClassImplCopyWith(_$TargetListClassImpl value,
          $Res Function(_$TargetListClassImpl) then) =
      __$$TargetListClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<ITargetListClass> targetList});
}

/// @nodoc
class __$$TargetListClassImplCopyWithImpl<$Res>
    extends _$TargetListClassCopyWithImpl<$Res, _$TargetListClassImpl>
    implements _$$TargetListClassImplCopyWith<$Res> {
  __$$TargetListClassImplCopyWithImpl(
      _$TargetListClassImpl _value, $Res Function(_$TargetListClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? targetList = null,
  }) {
    return _then(_$TargetListClassImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetList: null == targetList
          ? _value._targetList
          : targetList // ignore: cast_nullable_to_non_nullable
              as List<ITargetListClass>,
    ));
  }
}

/// @nodoc

class _$TargetListClassImpl extends _TargetListClass {
  const _$TargetListClassImpl(
      {required this.name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      required final List<ITargetListClass> targetList})
      : _targetList = targetList,
        super._();

  @override
  final String name;
  final List<ITargetListClass> _targetList;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ITargetListClass> get targetList {
    if (_targetList is EqualUnmodifiableListView) return _targetList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetList);
  }

  @override
  String toString() {
    return 'TargetListClass(name: $name, targetList: $targetList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetListClassImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._targetList, _targetList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_targetList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetListClassImplCopyWith<_$TargetListClassImpl> get copyWith =>
      __$$TargetListClassImplCopyWithImpl<_$TargetListClassImpl>(
          this, _$identity);
}

abstract class _TargetListClass extends TargetListClass {
  const factory _TargetListClass(
          {required final String name,
          @JsonKey(includeFromJson: false, includeToJson: false)
          required final List<ITargetListClass> targetList}) =
      _$TargetListClassImpl;
  const _TargetListClass._() : super._();

  @override
  String get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ITargetListClass> get targetList;
  @override
  @JsonKey(ignore: true)
  _$$TargetListClassImplCopyWith<_$TargetListClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
