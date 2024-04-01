import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

class ObjectNode {
  final DartType type;
  final Map<String, ObjectNode>? fields;

  ObjectNode._(this.type, this.fields);

  factory ObjectNode.primitive(final DartType type) {
    return ObjectNode._(type, null);
  }

  factory ObjectNode.visit(final DartType type) {
    if (type is VoidType) {
      return ObjectNode.primitive(type);
    }
    if (type is DynamicType) {
      return ObjectNode.primitive(type);
    }
    if (type is InterfaceType) {
      if (type.isDartCoreList) {
        final typeArguments = type.typeArguments;
        if (typeArguments.isNotEmpty) {
          final elementType = typeArguments.first;
          return ObjectNode._(type, {'items': ObjectNode.visit(elementType)});
        } else {
          return ObjectNode._(type, null);
        }
      } else {
        final element = type.element;
        if (element is ClassElement) {
          final fields = <String, ObjectNode>{};
          // TODO:実装   @JsonKey(ignore: true)だったら含めない
          for (final field in element.fields) {
            if (field.name == "hashCode" ||
                field.name == "runtimeType" ||
                field.name == "copyWith") {
              continue;
            }
            fields[field.name] = ObjectNode.visit(field.type);
          }
          return ObjectNode._(type, fields);
        }
      }
    } else if (type.isDartCoreBool ||
        type.isDartCoreInt ||
        type.isDartCoreDouble ||
        type.isDartCoreString) {
      return ObjectNode.primitive(type);
    } else {
      final element = type.element;
      if (element is ClassElement) {
        final fields = <String, ObjectNode>{};
        // TODO:実装   @JsonKey(ignore: true)だったら含めない
        for (final field in element.fields) {
          if (field.name == "hashCode" ||
              field.name == "runtimeType" ||
              field.name == "copyWith") {
            continue;
          }
          fields[field.name] = ObjectNode.visit(field.type);
        }
        for (final mixin in element.mixins) {
          for (final accessor in mixin.accessors) {
            // TODO:実装   @JsonKey(ignore: true)だったら含めない
            if (accessor.name == "copyWith" ||
                accessor.name == "hashCode" ||
                accessor.name == "runtimeType") {
              continue;
            }
            fields[accessor.name] = ObjectNode.visit(accessor.type.returnType);
          }
        }
        return ObjectNode._(type, fields);
      } else if (element is EnumElement) {
        return ObjectNode.primitive(type);
      } else if (element is TypeParameterElement) {
        // TypeParameterElementの場合、型パラメータの境界型を再帰的に処理する
        final boundType = element.bound;
        if (boundType != null) {
          return ObjectNode.visit(boundType);
        } else {
          return ObjectNode._(type, null);
        }
      } else {
        throw ObjectNodeException(
            "element is not ClassElement. ${type.toString()}");
      }
    }

    // ignore: dead_code
    throw ObjectNodeException("Unsupported type: ${type.toString()}");
  }

  bool get isObject => fields != null;

  String get name {
    final el = type.element;
    if (el == null) {
      return "Unknown";
    }
    return el.displayName[0].toUpperCase() + el.displayName.substring(1);
  }

  Map<String, dynamic>? toMap() {
    if (type is VoidType) {
      return null;
    }
    if (type is DynamicType) {
      return null;
    }
    if (isObject) {
      final m = fields!.map((key, value) => MapEntry(key, value.toMap()));
      return {"type": "object", "properties": m};
    } else if (type.isDartCoreList) {
      final items = fields!['items']!.toMap();
      return {"type": "array", "items": items};
    } else {
      return dartTypeToYamlType(type);
    }
  }
}

/// Dartの型をYAMLの型に変換するメソッド
Map<String, Object?> dartTypeToYamlType(DartType type) {
  if (type.isDartCoreString) {
    return {'type': 'string'};
  } else if (type.isDartCoreInt || type.isDartCoreDouble) {
    return {'type': 'number'};
  } else if (type.isDartCoreBool) {
    return {'type': 'boolean'};
  } else if (type.isDartCoreList) {
    return {'type': 'array'};
  } else if (type.isDartCoreMap) {
    return {'type': 'object'};
  } else if (type.element is EnumElement) {
    final EnumElement enumElement = type.element as EnumElement;
    final enumValues = enumElement.fields
        .where((field) => !field.isSynthetic)
        .where((field) => field.isConst && field.isConstantEvaluated)
        .map((field) => field.name)
        .toList();
    return {'type': 'string', 'enum': enumValues};
  } else if (type.isDartCoreList) {
    return {'type': 'array', 'items': ObjectNode.visit(type).toMap()};
  } else {
    return {'type': 'unknown'};
  }
}

class ObjectNodeException implements Exception {
  final String message;
  ObjectNodeException(this.message);
  @override
  String toString() => "[ObjectNodeException] $message";
}
