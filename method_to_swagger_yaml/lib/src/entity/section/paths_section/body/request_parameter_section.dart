import 'package:analyzer/dart/element/element.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/schema_section.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class RequestParameterSection {
  final List<ParameterSection> parameterList = [];
  late final String methodName;
  late final List<ParameterElement> listOfParameterPathType;
  late final List<ParameterElement> listOfParameterQueryType;

  RequestParameterSection({
    required this.methodName,
    required this.listOfParameterPathType,
    required this.listOfParameterQueryType,
  }) {
    for (final p in [...listOfParameterPathType, ...listOfParameterQueryType]) {
      final componentSection = ComponentSection(
        returnType: p.type,
        variableName: p.name,
        methodName: methodName,
      );

      ComponentSection.add(componentSection);

      final schemaSection = SchemaSection(
        componentSection: componentSection,
      );

      final computedValueList = p.metadata.map((e) => e.computeConstantValue());
      String? inValue;
      if (computedValueList.isEmpty) {
        inValue = 'query';
      } else {
        for (final c in computedValueList) {
          if (c == null) {
            continue;
          }

          final t = c.type;
          if (t == null) {
            continue;
          }
          if (t.element?.name != 'RequestParameter') {
            continue;
          }

          final divValue = c
              .getField("requestParameterDiv")
              ?.getField("toStringValue")
              ?.toStringValue();
          if (divValue == null) {
            continue;
          }
          final divEnum = RequestParameterDiv.from(value: divValue);
          switch (divEnum) {
            case RequestParameterDiv.path:
              inValue = 'path';
              break;
            case RequestParameterDiv.query:
              inValue = 'query';
              break;
            default:
              throw Exception('un supported RequestParameterDiv');
          }
          break;
        }
      }

      if (inValue == null) {
        inValue = 'query';
      }

      parameterList.add(
        ParameterSection(
          name: p.name,
          inValue: inValue,
          description: 'parameter description.',
          required: true,
          explode: false,
          schema: schemaSection,
        ),
      );
    }
  }

  Map<String, Object?> toMap() {
    return {
      "parameters": parameterList.map((e) => e.toMap()).toList(),
    };
  }
}

class ParameterSection {
  final String name;
  final String inValue;
  final String description;
  final bool required;
  final bool explode;
  final SchemaSection schema;

  ParameterSection({
    required this.name,
    required this.inValue,
    required this.description,
    required this.required,
    required this.explode,
    required this.schema,
  });

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};

    m.addAll({"name": name});
    m.addAll({"in": inValue});
    m.addAll({"description": description});
    m.addAll({"required": required});
    m.addAll({"explode": explode});
    final r = schema.toMap();
    if (r != null) {
      m.addAll(r);
    }

    return m;
  }
}
