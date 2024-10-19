import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/schema_section.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

// DartTypeをモック化するクラス
class _MockStringType extends DartType {
  @override
  String get name => 'String';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool get isDartCoreString => true;

  @override
  Element? get element => null;
}

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
      final useToString = canUseToString(p);

      late final ComponentSection componentSection;
      late final SchemaSection schemaSection;
      if (useToString) {
        final DartType stringType = _MockStringType();
        componentSection = ComponentSection(
          returnType: stringType,
          variableName: p.name,
          methodName: methodName,
        );

        ComponentSection.add(componentSection);

        schemaSection = SchemaSection(
          componentSection: componentSection,
        );
      } else {
        componentSection = ComponentSection(
          returnType: p.type,
          variableName: p.name,
          methodName: methodName,
        );

        ComponentSection.add(componentSection);

        schemaSection = SchemaSection(
          componentSection: componentSection,
        );
      }

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

// アノテーションを取り出してuseToStringか判定する
bool canUseToString(ParameterElement p) {
  final annotations =
      p.metadata.where((e) => e.element?.displayName == "RequestParameter");

  if (annotations.isEmpty) {
    return false;
  }
  final annotation = annotations.first;
  final rp = annotation.computeConstantValue();
  if (rp == null) {
    return false;
  }
  final useToString = rp.getField("useToString");
  if (useToString == null) {
    return false;
  }
  final value = useToString.toBoolValue();
  if (value == null) {
    return false;
  }
  return value;
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
