import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_serializable_class.g.dart';

@JsonSerializable()
class JsonSerializableClass {
  @JsonKey(name: 'json_serializable_class')
  final String value;

  JsonSerializableClass(this.value) {
    if (value.isEmpty) {
      throw JsonSerializableClassException(
          "JsonSerializableClass does not empty.");
    }
  }

  factory JsonSerializableClass.fromJson(Map<String, Object?> json) =>
      _$JsonSerializableClassFromJson(json);

  Map<String, Object?> toJson() => _$JsonSerializableClassToJson(this);

  @override
  String toString() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is JsonSerializableClass && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class JsonSerializableClassException implements Exception {
  late final String message;
  JsonSerializableClassException(final String message) {
    this.message = "[JsonSerializableClassException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
