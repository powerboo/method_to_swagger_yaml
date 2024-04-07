import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_of_val.freezed.dart';
part 'list_of_val.g.dart';

abstract class InterfaceId {
  Map<String, Object?> toJson();
}

@freezed
class ListOfValue with _$ListOfValue {
  const ListOfValue._();
  const factory ListOfValue({
    required ListOfAny<ValueIdWithEnum> listOfValue,
  }) = _ListOfValue;
  factory ListOfValue.fromJson(Map<String, Object?> json) =>
      _$ListOfValueFromJson(json);
}

class ListOfValueException implements Exception {
  late final String message;
  ListOfValueException(final String message) {
    this.message = "[ListOfValueException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class BaseSort<Id extends InterfaceId> {
  @JsonKey(name: 'sort_key')
  final Id sortKey;
  @JsonKey(name: 'sort_num')
  final SortNum? sortNum;

  BaseSort({
    required this.sortKey,
    required this.sortNum,
  });

  factory BaseSort.fromJson(Map<String, Object?> json) =>
      _$BaseSortFromJson(json, (Object? object) {
        // 型チェック
        if (object is! Map<String, Object?>) {
          throw Exception("object is not json.");
        }

        throw Exception("un supported json structure.");
      });

  Map<String, Object?> toJson() => _$BaseSortToJson(this, (Id id) {
        return id.toJson();
      });

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is BaseSort &&
          other.sortKey == sortKey &&
          other.sortNum == sortNum);

  @override
  int get hashCode =>
      runtimeType.hashCode ^ sortKey.hashCode ^ sortNum.hashCode;
}

@freezed
class ListOfAny<Id extends InterfaceId> with _$ListOfAny {
  const ListOfAny._();
  const factory ListOfAny({
    required List<BaseSort<Id>> listOfAny,
  }) = _ListOfAny;

  factory ListOfAny.fromJson(Map<String, Object?> json) =>
      _$ListOfAnyFromJson(json);
}

@JsonSerializable()
class SortNum {
  @JsonKey(name: 'sort_num')
  final int value;

  SortNum(this.value) {
    if (value < 0) {
      throw SortNumException("SortNum must have more than 1.");
    }
  }

  factory SortNum.fromJson(Map<String, Object?> json) =>
      _$SortNumFromJson(json);

  Map<String, Object?> toJson() => _$SortNumToJson(this);

  int toInt() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is SortNum && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class SortNumException implements Exception {
  late final String message;
  SortNumException(final String message) {
    this.message = "[SortNum] $message";
  }
  @override
  String toString() {
    return message;
  }
}

enum ValueDiv {
  Val0(0),
  Val1(1);

  final int toInt;
  const ValueDiv(this.toInt);
  factory ValueDiv.from({
    required int value,
  }) {
    final indexEnum = ValueDiv.values.firstWhere((e) => e.toInt == value);
    return indexEnum;
  }
}
// */

@JsonSerializable()
class ValueIdWithEnum implements InterfaceId {
  @JsonKey(name: 'value_id')
  final String value;

  @JsonKey(name: 'value_div')
  final ValueDiv valueDiv;

  ValueIdWithEnum(this.value, this.valueDiv) {
    if (value.isEmpty) {
      throw Exception("ValueId does not empty.");
    }
  }

  factory ValueIdWithEnum.fromJson(Map<String, Object?> json) =>
      _$ValueIdWithEnumFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ValueIdWithEnumToJson(this);

  @override
  String toString() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ValueIdWithEnum &&
          other.value == value &&
          other.valueDiv == valueDiv);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
