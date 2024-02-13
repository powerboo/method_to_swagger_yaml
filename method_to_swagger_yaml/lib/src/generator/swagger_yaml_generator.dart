import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'package:method_to_swagger_yaml/src/entity/output/yaml_entity.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
// import 'package:method_to_swagger_yaml/src/builder/generator.dart';
// import 'package:method_to_swagger_yaml/src/builder/constants/reader.dart' as my;
// import 'package:method_to_swagger_yaml/src/builder/generator_for_annotation.dart' as my;

class SwaggerYamlGenerator extends GeneratorForAnnotation<ConvertTargetClass> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // is element class?
    late final ClassElement classElement;
    if (element.kind != ElementKind.CLASS || element is! ClassElement) {
      throw InvalidGenerationSourceError(
        "[${element.displayName}] is not ClassElement. runtimeType is [${element.runtimeType}]",
        element: element,
      );
    }
    classElement = element;

    // only supports abstract classes
    if (!classElement.isAbstract) {
      throw InvalidGenerationSourceError(
        "This generator only supports abstract classes. annotated class [${classElement.displayName}]",
        element: classElement,
      );
    }

    // does not have method
    if (classElement.methods.isEmpty) {
      throw InvalidGenerationSourceError(
        "[${element.displayName}] does not have method.",
        element: classElement,
      );
    }

    // does not have annotated method
    bool isAnnotated = false;
    for (final m in classElement.methods) {
      for (final annotation in m.metadata) {
        if ('ConvertTargetMethod' == annotation.element?.displayName) {
          isAnnotated = true;
        }
      }
    }
    if (!isAnnotated) {
      throw InvalidGenerationSourceError(
        "[${element.displayName}] does not have annotated method.",
        element: classElement,
      );
    }

    final yamlEntity = YamlEntity(classElement: classElement);

    return yamlEntity.dump();
  }
}
