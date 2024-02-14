import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

/* 
// ------------------------------------------------------------
// convert_target_method
// ------------------------------------------------------------
void main() async {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  final path = p.join('test', 'convert_target_method', 'test_data');

  // -------------- argument ----------------
  // /*
  // named argument
  final namedArgument = await initializeLibraryReaderForDirectory(
    p.join(path, 'argument'),
    'named_argument.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    namedArgument,
    SwaggerYamlGenerator(),
  );
  // */

  // positional argument
  final positionalArgument = await initializeLibraryReaderForDirectory(
    p.join(path, 'argument'),
    'positional_argument.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    positionalArgument,
    SwaggerYamlGenerator(),
  );
}

// */