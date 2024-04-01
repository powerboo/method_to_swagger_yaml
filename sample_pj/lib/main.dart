import 'package:sample_pj/repository/object/freezed_class.dart';
import 'package:sample_pj/repository/object/val/freezed_id.dart';
import 'package:sample_pj/repository/object/val/freezed_value.dart';

void main() {
  const val = FreezedClass(
    freezedId: FreezedId(freezedId: "1"),
    freezedValue: FreezedValue(value: 1),
  );
  print(val.toJson());
}
