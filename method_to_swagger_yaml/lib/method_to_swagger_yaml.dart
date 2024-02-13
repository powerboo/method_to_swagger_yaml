library method_to_swagger_yaml;

import 'package:build/build.dart';
import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder swaggerYamlBuilder(BuilderOptions options) {
  final builder = LibraryBuilder(
    SwaggerYamlGenerator(),
    generatedExtension: ".yaml.dart",
    options: options,
  );
  return builder;
}
