import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow("[DoesNotHaveMethod] does not have method.")
@ConvertTargetClass(
  title: "does not have method.",
  version: "0.0.1",
)
abstract class DoesNotHaveMethod {
  const DoesNotHaveMethod();
}
