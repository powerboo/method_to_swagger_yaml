import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow("This generator only supports abstract classes. annotated class [OnlySupportAbstractClass]")
@ConvertTargetClass(
  title: "only supports abstract classes.",
  version: "0.0.1",
)
class OnlySupportAbstractClass {
  const OnlySupportAbstractClass();
}
