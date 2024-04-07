// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_val.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSort<Id> _$BaseSortFromJson<Id extends InterfaceId>(
  Map<String, dynamic> json,
  Id Function(Object? json) fromJsonId,
) =>
    BaseSort<Id>(
      sortKey: fromJsonId(json['sort_key']),
      sortNum: SortNum.fromJson(json['sort_num'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseSortToJson<Id extends InterfaceId>(
  BaseSort<Id> instance,
  Object? Function(Id value) toJsonId,
) =>
    <String, dynamic>{
      'sort_key': toJsonId(instance.sortKey),
      'sort_num': instance.sortNum,
    };

SortNum _$SortNumFromJson(Map<String, dynamic> json) => SortNum(
      json['sort_num'] as int,
    );

Map<String, dynamic> _$SortNumToJson(SortNum instance) => <String, dynamic>{
      'sort_num': instance.value,
    };

ValueId _$ValueIdFromJson(Map<String, dynamic> json) => ValueId(
      json['value_id'] as String,
    );

Map<String, dynamic> _$ValueIdToJson(ValueId instance) => <String, dynamic>{
      'value_id': instance.value,
    };

_$ListOfAnyImpl<Id> _$$ListOfAnyImplFromJson<Id extends InterfaceId>(
        Map<String, dynamic> json) =>
    _$ListOfAnyImpl<Id>(
      listOfAny: (json['listOfAny'] as List<dynamic>)
          .map((e) => BaseSort<Id>.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListOfAnyImplToJson<Id extends InterfaceId>(
        _$ListOfAnyImpl<Id> instance) =>
    <String, dynamic>{
      'listOfAny': instance.listOfAny,
    };

_$ListOfValueImpl _$$ListOfValueImplFromJson(Map<String, dynamic> json) =>
    _$ListOfValueImpl(
      listOfValue: ListOfAny<ValueId>.fromJson(
          json['listOfValue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ListOfValueImplToJson(_$ListOfValueImpl instance) =>
    <String, dynamic>{
      'listOfValue': instance.listOfValue,
    };
