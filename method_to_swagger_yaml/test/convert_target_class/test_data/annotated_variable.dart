import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow("[annotatedVariable] is not ClassElement. runtimeType is [TopLevelVariableElementImpl]")
@ConvertTargetClass(
  title: "annotated variable.",
  version: "0.0.1",
)
final annotatedVariable = "";
