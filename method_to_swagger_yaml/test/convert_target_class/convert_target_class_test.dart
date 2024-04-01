import 'dart:io';

import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import '../source_gen_test/generate_for_element.dart';

// ------------------------------------------------------------
// convert_target_class
// ------------------------------------------------------------
void main() async {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  final path = p.join('test', 'convert_target_class', 'test_data');

  // annotated variable
  final annotatedVariable = await initializeLibraryReaderForDirectory(
    path,
    'annotated_variable.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    annotatedVariable,
    SwaggerYamlGenerator(),
  );

  // only support abstract class
  final onlySupportAbstractClass = await initializeLibraryReaderForDirectory(
    path,
    'only_support_abstract_class.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    onlySupportAbstractClass,
    SwaggerYamlGenerator(),
  );

  // does not have method
  final doesNotHaveMethod = await initializeLibraryReaderForDirectory(
    path,
    'does_not_have_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    doesNotHaveMethod,
    SwaggerYamlGenerator(),
  );

  // does not have annotated method
  final doesNotHaveAnnotatedMethod = await initializeLibraryReaderForDirectory(
    path,
    'does_not_have_annotated_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    doesNotHaveAnnotatedMethod,
    SwaggerYamlGenerator(),
  );

  // tag name is empty
  final tagNameIsEmpty = await initializeLibraryReaderForDirectory(
    path,
    'tag_name_is_empty.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    tagNameIsEmpty,
    SwaggerYamlGenerator(),
  );

  // one method
  test('one_method', () async {
    await _test(
      path: path,
      fileName: "one_method",
      className: "OneMethod",
    );
  });

  // multiple method
  test('multiple_method', () async {
    await _test(
      path: path,
      fileName: "multiple_method",
      className: "MultipleMethod",
    );
  });

  // multiple method with same tag
  test('multiple_method_with_same_tag', () async {
    await _test(
      path: path,
      fileName: "multiple_method_with_same_tag",
      className: "MultipleMethodWithSameTag",
    );
  });

  // multiple method with different tag
  test('multiple_method_with_different_tag', () async {
    await _test(
      path: path,
      fileName: "multiple_method_with_different_tag",
      className: "MultipleMethodDifferentTag",
    );
  });

  // zero tag
  test('zero_tag', () async {
    await _test(
      path: path,
      fileName: "zero_tag",
      className: "ZeroTag",
    );
  });

  // one tag
  test('single_tag', () async {
    await _test(
      path: path,
      fileName: "single_tag",
      className: "SingleTag",
    );
  });

  // multiple tag
  test('multiple_tag', () async {
    await _test(
      path: path,
      fileName: "multiple_tag",
      className: "MultipleTag",
    );
  });
}

Future<void> _test({
  required String path,
  required String fileName,
  required String className,
}) async {
  final libraryReader = await initializeLibraryReaderForDirectory(
    path,
    '${fileName}.dart',
  );

  final createdValue = await generateTextForElement(
    SwaggerYamlGenerator(),
    libraryReader,
    className,
  );

  final expectedPath =
      p.join('test', 'convert_target_class', 'expected', '${fileName}.yaml');
  final expectedValue = File(expectedPath).readAsStringSync();

  expect(createdValue, expectedValue);
}
