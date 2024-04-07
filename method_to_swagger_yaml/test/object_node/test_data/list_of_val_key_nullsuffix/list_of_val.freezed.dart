// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_of_val.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListOfValue _$ListOfValueFromJson(Map<String, dynamic> json) {
  return _ListOfValue.fromJson(json);
}

/// @nodoc
mixin _$ListOfValue {
  ListOfAny<ValueIdWithEnum> get listOfValue =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListOfValueCopyWith<ListOfValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListOfValueCopyWith<$Res> {
  factory $ListOfValueCopyWith(
          ListOfValue value, $Res Function(ListOfValue) then) =
      _$ListOfValueCopyWithImpl<$Res, ListOfValue>;
  @useResult
  $Res call({ListOfAny<ValueIdWithEnum> listOfValue});

  $ListOfAnyCopyWith<ValueIdWithEnum, $Res> get listOfValue;
}

/// @nodoc
class _$ListOfValueCopyWithImpl<$Res, $Val extends ListOfValue>
    implements $ListOfValueCopyWith<$Res> {
  _$ListOfValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfValue = null,
  }) {
    return _then(_value.copyWith(
      listOfValue: null == listOfValue
          ? _value.listOfValue
          : listOfValue // ignore: cast_nullable_to_non_nullable
              as ListOfAny<ValueIdWithEnum>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ListOfAnyCopyWith<ValueIdWithEnum, $Res> get listOfValue {
    return $ListOfAnyCopyWith<ValueIdWithEnum, $Res>(_value.listOfValue,
        (value) {
      return _then(_value.copyWith(listOfValue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ListOfValueImplCopyWith<$Res>
    implements $ListOfValueCopyWith<$Res> {
  factory _$$ListOfValueImplCopyWith(
          _$ListOfValueImpl value, $Res Function(_$ListOfValueImpl) then) =
      __$$ListOfValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ListOfAny<ValueIdWithEnum> listOfValue});

  @override
  $ListOfAnyCopyWith<ValueIdWithEnum, $Res> get listOfValue;
}

/// @nodoc
class __$$ListOfValueImplCopyWithImpl<$Res>
    extends _$ListOfValueCopyWithImpl<$Res, _$ListOfValueImpl>
    implements _$$ListOfValueImplCopyWith<$Res> {
  __$$ListOfValueImplCopyWithImpl(
      _$ListOfValueImpl _value, $Res Function(_$ListOfValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfValue = null,
  }) {
    return _then(_$ListOfValueImpl(
      listOfValue: null == listOfValue
          ? _value.listOfValue
          : listOfValue // ignore: cast_nullable_to_non_nullable
              as ListOfAny<ValueIdWithEnum>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListOfValueImpl extends _ListOfValue {
  const _$ListOfValueImpl({required this.listOfValue}) : super._();

  factory _$ListOfValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListOfValueImplFromJson(json);

  @override
  final ListOfAny<ValueIdWithEnum> listOfValue;

  @override
  String toString() {
    return 'ListOfValue(listOfValue: $listOfValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListOfValueImpl &&
            (identical(other.listOfValue, listOfValue) ||
                other.listOfValue == listOfValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, listOfValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListOfValueImplCopyWith<_$ListOfValueImpl> get copyWith =>
      __$$ListOfValueImplCopyWithImpl<_$ListOfValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListOfValueImplToJson(
      this,
    );
  }
}

abstract class _ListOfValue extends ListOfValue {
  const factory _ListOfValue(
          {required final ListOfAny<ValueIdWithEnum> listOfValue}) =
      _$ListOfValueImpl;
  const _ListOfValue._() : super._();

  factory _ListOfValue.fromJson(Map<String, dynamic> json) =
      _$ListOfValueImpl.fromJson;

  @override
  ListOfAny<ValueIdWithEnum> get listOfValue;
  @override
  @JsonKey(ignore: true)
  _$$ListOfValueImplCopyWith<_$ListOfValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListOfAny<Id> _$ListOfAnyFromJson<Id extends InterfaceId>(
    Map<String, dynamic> json) {
  return _ListOfAny<Id>.fromJson(json);
}

/// @nodoc
mixin _$ListOfAny<Id extends InterfaceId> {
  List<BaseSort<Id>> get listOfAny => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListOfAnyCopyWith<Id, ListOfAny<Id>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListOfAnyCopyWith<Id extends InterfaceId, $Res> {
  factory $ListOfAnyCopyWith(
          ListOfAny<Id> value, $Res Function(ListOfAny<Id>) then) =
      _$ListOfAnyCopyWithImpl<Id, $Res, ListOfAny<Id>>;
  @useResult
  $Res call({List<BaseSort<Id>> listOfAny});
}

/// @nodoc
class _$ListOfAnyCopyWithImpl<Id extends InterfaceId, $Res,
    $Val extends ListOfAny<Id>> implements $ListOfAnyCopyWith<Id, $Res> {
  _$ListOfAnyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfAny = null,
  }) {
    return _then(_value.copyWith(
      listOfAny: null == listOfAny
          ? _value.listOfAny
          : listOfAny // ignore: cast_nullable_to_non_nullable
              as List<BaseSort<Id>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListOfAnyImplCopyWith<Id extends InterfaceId, $Res>
    implements $ListOfAnyCopyWith<Id, $Res> {
  factory _$$ListOfAnyImplCopyWith(
          _$ListOfAnyImpl<Id> value, $Res Function(_$ListOfAnyImpl<Id>) then) =
      __$$ListOfAnyImplCopyWithImpl<Id, $Res>;
  @override
  @useResult
  $Res call({List<BaseSort<Id>> listOfAny});
}

/// @nodoc
class __$$ListOfAnyImplCopyWithImpl<Id extends InterfaceId, $Res>
    extends _$ListOfAnyCopyWithImpl<Id, $Res, _$ListOfAnyImpl<Id>>
    implements _$$ListOfAnyImplCopyWith<Id, $Res> {
  __$$ListOfAnyImplCopyWithImpl(
      _$ListOfAnyImpl<Id> _value, $Res Function(_$ListOfAnyImpl<Id>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfAny = null,
  }) {
    return _then(_$ListOfAnyImpl<Id>(
      listOfAny: null == listOfAny
          ? _value._listOfAny
          : listOfAny // ignore: cast_nullable_to_non_nullable
              as List<BaseSort<Id>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListOfAnyImpl<Id extends InterfaceId> extends _ListOfAny<Id> {
  const _$ListOfAnyImpl({required final List<BaseSort<Id>> listOfAny})
      : _listOfAny = listOfAny,
        super._();

  factory _$ListOfAnyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListOfAnyImplFromJson(json);

  final List<BaseSort<Id>> _listOfAny;
  @override
  List<BaseSort<Id>> get listOfAny {
    if (_listOfAny is EqualUnmodifiableListView) return _listOfAny;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOfAny);
  }

  @override
  String toString() {
    return 'ListOfAny<$Id>(listOfAny: $listOfAny)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListOfAnyImpl<Id> &&
            const DeepCollectionEquality()
                .equals(other._listOfAny, _listOfAny));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_listOfAny));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListOfAnyImplCopyWith<Id, _$ListOfAnyImpl<Id>> get copyWith =>
      __$$ListOfAnyImplCopyWithImpl<Id, _$ListOfAnyImpl<Id>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListOfAnyImplToJson<Id>(
      this,
    );
  }
}

abstract class _ListOfAny<Id extends InterfaceId> extends ListOfAny<Id> {
  const factory _ListOfAny({required final List<BaseSort<Id>> listOfAny}) =
      _$ListOfAnyImpl<Id>;
  const _ListOfAny._() : super._();

  factory _ListOfAny.fromJson(Map<String, dynamic> json) =
      _$ListOfAnyImpl<Id>.fromJson;

  @override
  List<BaseSort<Id>> get listOfAny;
  @override
  @JsonKey(ignore: true)
  _$$ListOfAnyImplCopyWith<Id, _$ListOfAnyImpl<Id>> get copyWith =>
      throw _privateConstructorUsedError;
}
