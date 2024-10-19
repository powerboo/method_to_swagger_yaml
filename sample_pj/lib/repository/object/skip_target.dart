import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

part 'skip_target.freezed.dart';
part 'skip_target.g.dart';

@freezed
class SkipTarget with _$SkipTarget {
  const SkipTarget._();
  const factory SkipTarget({
    required String skipTarget,
    @IgnoreField() required String ignoreTarget,
  }) = _SkipTarget;
  factory SkipTarget.fromJson(Map<String, Object?> json) =>
      _$SkipTargetFromJson(json);
}

class SkipTargetException implements Exception {
  late final String message;
  SkipTargetException(final String message) {
    this.message = "[SkipTargetException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
