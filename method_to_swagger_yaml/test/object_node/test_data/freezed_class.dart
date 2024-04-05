import 'package:freezed_annotation/freezed_annotation.dart';

import 'val/freezed_id.dart';
import 'val/freezed_value.dart';

part 'freezed_class.freezed.dart';
part 'freezed_class.g.dart';

@freezed
class FreezedClass with _$FreezedClass {
  const FreezedClass._();
  const factory FreezedClass({
    required FreezedId freezedId,
    required FreezedValue freezedValue,
  }) = _FreezedClass;
  factory FreezedClass.fromJson(Map<String, Object?> json) =>
      _$FreezedClassFromJson(json);
}

class FreezedClassException implements Exception {
  late final String message;
  FreezedClassException(final String message) {
    this.message = "[FreezedClassException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
