import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_value.freezed.dart';
part 'freezed_value.g.dart';

@freezed
class FreezedValue with _$FreezedValue {
  const FreezedValue._();
  const factory FreezedValue({
    required int value,
  }) = _FreezedValue;
  factory FreezedValue.fromJson(Map<String, Object?> json) =>
      _$FreezedValueFromJson(json);
}

class FreezedValueException implements Exception {
  late final String message;
  FreezedValueException(final String message) {
    this.message = "[FreezedValueException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
