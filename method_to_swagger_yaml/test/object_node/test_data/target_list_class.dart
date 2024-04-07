import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_list_class.freezed.dart';

@freezed
class TargetListClass with _$TargetListClass {
  const TargetListClass._();
  const factory TargetListClass({
    required String name,
    required List<ITargetListClass> targetList,
  }) = _TargetListClass;
}

abstract class ITargetListClass {
  String get name;
}
