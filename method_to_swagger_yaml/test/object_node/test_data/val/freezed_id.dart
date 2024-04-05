import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_id.freezed.dart';
part 'freezed_id.g.dart';

@freezed
class FreezedId with _$FreezedId {
  const FreezedId._();
  const factory FreezedId({
    required String freezedId,
  }) = _FreezedId;
  factory FreezedId.fromJson(Map<String, Object?> json) =>
      _$FreezedIdFromJson(json);
}

class FreezedIdException implements Exception {
  late final String message;
  FreezedIdException(final String message) {
    this.message = "[FreezedIdException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
