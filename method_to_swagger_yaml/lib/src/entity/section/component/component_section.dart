import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/object_node.dart';

final List<ComponentSection> componentSectionList = [];

class ComponentSection {
  final String methodName;
  final String variableName;
  final DartType returnType;
  final ObjectNode objectNode;
  final Element element;

  ComponentSection({
    required this.methodName,
    required this.variableName,
    required this.returnType,
    required this.element,
  }) : objectNode = ObjectNode.visit(returnType);

  static add(ComponentSection componentSection) {
    // IgnoreFieldInYamlになっている場合は追加しない
    if (componentSection.element.metadata
        .any((e) => e.element?.displayName == 'IgnoreFieldInYaml')) {
      return;
    }
    componentSectionList.add(componentSection);
  }

  static clear() {
    componentSectionList.clear();
  }

  String get name {
    return methodName[0].toUpperCase() +
        methodName.substring(1) +
        variableName[0].toUpperCase() +
        variableName.substring(1);
  }

  Map<String, Object?>? toMap() {
    final Map<String, Object?> m = {};
    final result = objectNode.toMap();
    if (result == null) {
      return null;
    }
    m.addAll(result);

    return {name: m};
  }

  Map<String, Object?> toRefPath() {
    return {"\$ref": '#/components/schemas/${name}'};
  }
}
