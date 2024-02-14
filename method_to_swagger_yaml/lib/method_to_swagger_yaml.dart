library method_to_swagger_yaml;

import 'package:build/build.dart';
import 'package:method_to_swagger_yaml/src/builder/yaml_builder.dart';
import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';

Builder swaggerYamlBuilder(BuilderOptions options) {
  final builder = YamlBuilder(
    SwaggerYamlGenerator(),
  );
  return builder;
}
