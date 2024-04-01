/*
      type: object
      properties:
        id:
          type: object
          properties:
            id: 
              type: string
 */
import 'package:analyzer/dart/element/element.dart';

class ObjectNode {
  final int rank;
  final List<ObjectNode> objectNodeList = [];
  final ParameterElement parameterElement;
  ElementAnnotation? jsonSerializableAnnotation;
  String? _jsonKey;

  ObjectNode({
    required this.rank,
    required this.parameterElement,
    this.jsonSerializableAnnotation,
  });

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    if (!isObject) {
      m.addAll({"type": type});
      return m;
    }

    m.addAll({"type": "object"});
    final Map<String, Object?> om = {};
    for (final o in objectNodeList) {
      om.addAll(o.toMap());
    }
    m.addAll({"properties": om});
    return m;
  }

  bool get isObject {
    final typeName =
        parameterElement.type.getDisplayString(withNullability: false);
    return !_isPrimitiveType(typeName);
  }

  String get nodeName {
    return parameterElement.displayName;
  }

  String get type {
    return parameterElement.type.getDisplayString(withNullability: false);
  }

  void addChild(ObjectNode node) {
    objectNodeList.add(node);
  }

  void setAnnotation(
    ElementAnnotation el,
    String value,
  ) {
    jsonSerializableAnnotation = el;
    _jsonKey = value;
  }

  String get jsonKey {
    if (_jsonKey == null) {
      return nodeName;
    }
    return _jsonKey!;
  }

  String dump({String base = ""}) {
    StringBuffer buffer = StringBuffer();

    String unit = "  ";

    if (isObject) {
      // set space
      for (int count = 1; count <= rank; count++) {
        buffer.write(unit);
      }
      buffer.writeln("${base}type: object");

      // set space
      for (int count = 1; count <= rank; count++) {
        buffer.write(unit);
      }
      buffer.writeln("${base}properties:");

      // set space
      for (int count = 1; count <= rank; count++) {
        buffer.write(unit);
      }
      buffer.writeln("${base}${unit}${nodeName}:");

      String space = "${base}${unit}";
      for (final node in objectNodeList) {
        for (int count = 1; count <= rank; count++) {
          space += unit;
        }
        buffer.write(node.dump(base: space));
      }
    } else {
      final (div, _) = toJsonPrimitiveType(type);

      if (rank == 1) {
        buffer.writeln("${base}${unit}type: ${div.toStringValue}");
      } else {
        // set space
        for (int count = 1; count <= rank; count++) {
          buffer.write(unit);
        }
        buffer.writeln("${unit}${unit}${unit}type: object");

        // set space
        for (int count = 1; count <= rank; count++) {
          buffer.write(unit);
        }
        buffer.writeln("${unit}${unit}${unit}properties:");

        // set space
        for (int count = 1; count <= rank; count++) {
          buffer.write(unit);
        }
        buffer.writeln("${unit}${unit}${unit}${unit}${nodeName}:");

        // set space
        for (int count = 1; count <= rank; count++) {
          buffer.write(unit);
        }
        buffer.writeln(
            "${unit}${unit}${unit}${unit}${unit}type: ${div.toStringValue}");
      }
    }

    return buffer.toString();
  }

  (JsonTypeDiv, String?) toJsonPrimitiveType(String name) {
    switch (name) {
      case 'int':
        return (JsonTypeDiv.integer, 'int');
      case 'double':
        return (JsonTypeDiv.number, 'double');
      case 'String':
        return (JsonTypeDiv.string, null);
      case 'bool':
        return (JsonTypeDiv.boolean, null);
      case 'List':
        return (JsonTypeDiv.array, null);
      case 'dynamic':
        return (JsonTypeDiv.string, null);
      default:
        return (JsonTypeDiv.object, null);
    }
  }
}

void recursiveNode(
  ObjectNode parentNode,
  ParameterElement parameterElement,
  int rank,
) {
  // Check if the json key annotation is present
  final el = parameterElement.type.element;
  if (el == null) {
    return;
  }
  ElementAnnotation? annotation = null;
  String? jsonKey = null;
  final fields = el.children.where((e) => e.kind == ElementKind.FIELD);
  for (final f in fields) {
    final target =
        f.metadata.where((m) => m.element?.enclosingElement?.name == 'JsonKey');
    if (target.isEmpty) {
      continue;
    }
    final value = target.first.computeConstantValue();
    if (value == null) {
      continue;
    }
    final name = value.getField("name")?.toStringValue();
    if (name == null) {
      continue;
    }
    annotation = target.first;
    jsonKey = name;
  }

  final typeName =
      parameterElement.type.getDisplayString(withNullability: false);

  // end node
  if (_isPrimitiveType(typeName)) {
    final childNode = ObjectNode(
      parameterElement: parameterElement,
      rank: rank,
    );

    if (annotation != null && jsonKey != null) {
      parentNode.setAnnotation(annotation, jsonKey);
    }

    parentNode.addChild(childNode);
  }
  // object
  else {
    if (rank == 1) {
      if (annotation != null && jsonKey != null) {
        parentNode.setAnnotation(annotation, jsonKey);
      }

      for (final field in el.children
          .where((e) => e.name == "")
          .where((e) => e.kind == ElementKind.CONSTRUCTOR)
          .first
          .children
          .where((e) => e is ParameterElement)
          .toList()
          .cast<ParameterElement>()) {
        recursiveNode(parentNode, field, rank + 1);
      }
    } else {
      final childNode = ObjectNode(
        parameterElement: parameterElement,
        rank: rank,
      );

      if (annotation != null && jsonKey != null) {
        parentNode.setAnnotation(annotation, jsonKey);
      }

      parentNode.addChild(childNode);

      for (final field in el.children
          .where((e) => e.name == "")
          .where((e) => e.kind == ElementKind.CONSTRUCTOR)
          .first
          .children
          .where((e) => e is ParameterElement)
          .toList()
          .cast<ParameterElement>()) {
        recursiveNode(childNode, field, rank + 1);
      }
    }
  }
}

bool _isPrimitiveType(String? typeName) {
  return [
    'int',
    'double',
    'String',
    'bool',
    'num',
    'dynamic',
  ].contains(typeName);
}

extension KebabCase on String {
  String toKebabCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '-${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }

  String toSnakeCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '_${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }
}

enum JsonTypeDiv {
  string("string"),
  number("number"),
  integer("integer"),
  boolean("boolean"),
  array("array"),
  object("object"),
  ;

  final String toStringValue;
  const JsonTypeDiv(this.toStringValue);
  factory JsonTypeDiv.from({
    required String value,
  }) {
    final indexEnum =
        JsonTypeDiv.values.firstWhere((e) => e.toStringValue == value);
    return indexEnum;
  }
}
