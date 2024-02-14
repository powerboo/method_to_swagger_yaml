import 'dart:io';

import 'package:method_to_swagger_yaml/src/builder/yaml_builder.dart';
import 'package:test/test.dart';
import 'package:build_test/build_test.dart';
import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';

// ------------------------------------------------------------
// convert_target_class
// ------------------------------------------------------------
void main() async {
  // one method
  test("one_method", () async {
    const String fileName = "one_method";
    await _test(fileName: fileName);
  });

  // multiple method
  test("multiple_method", () async {
    const String fileName = "multiple_method";
    await _test(fileName: fileName);
  });

  // multiple method with same tag
  test("multiple_method_with_same_tag", () async {
    const String fileName = "multiple_method_with_same_tag";
    await _test(fileName: fileName);
  });

  // multiple method with different tag
  test("multiple_method_with_different_tag", () async {
    const String fileName = "multiple_method_with_different_tag";
    await _test(fileName: fileName);
  });

  // zero tag
  test("zero_tag", () async {
    const String fileName = "zero_tag";
    await _test(fileName: fileName);
  });

  // one tag
  test("single_tag", () async {
    const String fileName = "single_tag";
    await _test(fileName: fileName);
  });

  // multiple tag
  test("multiple_tag", () async {
    const String fileName = "multiple_tag";
    await _test(fileName: fileName);
  });
  /*
  TODO: implements
  // annotated variable
  test("annotated variable", () async {
    const String fileName = "annotated_variable";
    await _test(fileName: fileName);
  });

  // only support abstract class
  test("only support abstract class", () async {
    const String fileName = "only_support_abstract_class";
    _test(fileName: fileName);
  });

  // does not have method
  test("does not have method", () async {
    const String fileName = "does_not_have_method";
    _test(fileName: fileName);
  });

  // does not have annotated method
  test("does_not_have_annotated_method", () async {
    const String fileName = "does_not_have_annotated_method";
    await _test(fileName: fileName);
  });
  
  // tag name is empty
  test("tag_name_is_empty", () async {
    const String fileName = "tag_name_is_empty";
    await _test(fileName: fileName);
  });
  // */
}

Future<void> _test({
  required String fileName,
}) async {
  final input = {
    'a|${fileName}.dart': File("test/convert_target_class/input_data/${fileName}.dart").readAsStringSync(),
  };
  final output = {
    'a|${fileName}.yaml': File("test/convert_target_class/expected/${fileName}.yaml").readAsStringSync(),
  };

  await testBuilder(
    YamlBuilder(
      SwaggerYamlGenerator(),
    ),
    input,
    outputs: output,
  );
}
