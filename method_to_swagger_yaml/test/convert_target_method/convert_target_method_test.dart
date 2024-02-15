// ------------------------------------------------------------
// convert_target_method
// ------------------------------------------------------------
import 'dart:io';

import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import '../source_gen_test/generate_for_element.dart';

void main() async {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  final path = p.join('test', 'convert_target_method', 'test_data');

  // -------------- argument ----------------
  // named argument
  test("named argument", () async {
    await _test(
      path: p.join(path, "argument"),
      fileName: 'named_argument',
      className: 'NamedArgument',
    );
  });

  // positional argument
  test("positional argument", () async {
    await _test(
      path: p.join(path, "argument"),
      fileName: 'positional_argument',
      className: 'PositionalArgumentClass',
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

  final expectedPath = p.join('test', 'convert_target_method', 'expected', 'argument', '${fileName}.yaml');
  final expectedValue = File(expectedPath).readAsStringSync();

  expect(createdValue, expectedValue);
}
