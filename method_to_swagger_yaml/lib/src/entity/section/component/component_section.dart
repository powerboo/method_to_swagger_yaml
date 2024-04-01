import 'package:analyzer/dart/element/type.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/object_node.dart';

final List<ComponentSection> componentSectionList = [];

class ComponentSection {
  final String methodName;
  final String variableName;
  final DartType returnType;
  final ObjectNode objectNode;

  ComponentSection({
    required this.methodName,
    required this.variableName,
    required this.returnType,
  }) : objectNode = ObjectNode.visit(returnType);

  static add(ComponentSection componentSection) {
    componentSectionList.add(componentSection);
  }

  static clear() {
    componentSectionList.clear();
  }

  bool get isObject {
    return objectNode.isObject;
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
