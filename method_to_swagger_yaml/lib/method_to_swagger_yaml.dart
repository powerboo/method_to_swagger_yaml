library method_to_swagger_yaml;

import 'package:build/build.dart';
import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import 'package:method_to_swagger_yaml/src/builder/builder.dart' as my;

Builder swaggerYamlBuilder(BuilderOptions options) {
  final builder = my.YamlBuilder(
    SwaggerYamlGenerator(),
    generatedExtension: ".yaml",
    options: options,
  );
  return builder;
}
