import 'package:analyzer/dart/element/type.dart';

class ObjectNode {
  final DartType type;
  final Map<String, ObjectNode> properties;
  final ObjectNode? itemNode;

  ObjectNode._(this.type, this.properties, {this.itemNode});

  factory ObjectNode.visit(final DartType type) {
    final properties = <String, ObjectNode>{};

    if (type is InterfaceType) {
      if (type.element.name == 'DateTime') {
        return ObjectNode._(type, properties);
      }

      for (final field in type.element.fields) {
        if (field.isStatic) continue;
        if (field.name == 'hashCode') continue;

        final fieldType = field.type;
        final fieldNode = _createObjectNodeForType(fieldType);
        properties[field.name] = fieldNode;
      }

      // Handling for freezed classes
      if (type.element.constructors.any((c) => c.isFactory)) {
        // クラスのプロパティを取得
        for (final accessor in type.element.accessors) {
          if (accessor.isGetter &&
              !accessor.isStatic &&
              accessor.name != 'runtimeType' &&
              accessor.name != 'hashCode' &&
              accessor.name != 'copyWith' &&
              !properties.containsKey(accessor.name)) {
            final fieldName = accessor.name;
            final fieldNode = _createObjectNodeForType(accessor.returnType);
            properties[fieldName] = fieldNode;
          }
        }
        // ミックスインのプロパティを取得
        for (final mixin in type.element.mixins) {
          for (final accessor in mixin.accessors) {
            if (accessor.isGetter &&
                !accessor.isStatic &&
                accessor.name != 'runtimeType' &&
                accessor.name != 'hashCode' &&
                accessor.name != 'copyWith') {
              final fieldName = accessor.name;
              final fieldNode = _createObjectNodeForType(accessor.returnType);
              properties[fieldName] = fieldNode;
            }
          }
        }
      }
    } else if (type is ParameterizedType && type.isDartCoreList) {
      final itemType = type.typeArguments.first;
      final itemNode = _createObjectNodeForType(itemType);
      return ObjectNode._(type, properties, itemNode: itemNode);
    } else if (type is TypeParameterType) {
      return ObjectNode._(type, properties);
    }

    return ObjectNode._(type, properties);
  }

  Map<String, dynamic>? toMap() {
    if (type is VoidType) {
      return null;
    }
    if (type is DynamicType) {
      return null;
    }

    if (type.element?.name == 'DateTime') {
      return {'type': 'string', 'format': 'date-time'};
    }

    if (type.isDartCoreString) {
      return {'type': 'string'};
    } else if (type.isDartCoreInt) {
      return {'type': 'integer'};
    } else if (type.isDartCoreBool) {
      return {'type': 'boolean'};
    } else if (type.isDartCoreDouble) {
      return {'type': 'number'};
    } else if (type is ParameterizedType && type.isDartCoreList) {
      return {
        'type': 'array',
        'items': itemNode?.toMap() ?? {'type': 'string'},
      };
    } else if (type is InterfaceType) {
      final map = <String, dynamic>{
        'type': 'object',
        'properties': {},
      };

      for (final entry in properties.entries) {
        final value = entry.value.toMap();
        if (value != null) {
          map['properties'][entry.key] = value;
        }
      }

      return map;
    } else if (type is TypeParameterType) {
      return null;
    }

    return null;
  }
}

ObjectNode _createObjectNodeForType(DartType type) {
  if (type.isDartCoreString ||
      type.isDartCoreBool ||
      type.isDartCoreInt ||
      type.isDartCoreDouble) {
    return ObjectNode._(type, {});
  } else if (type is ParameterizedType && type.isDartCoreList) {
    final itemType = type.typeArguments.first;
    final itemNode = _createObjectNodeForType(itemType);
    return ObjectNode._(type, {}, itemNode: itemNode);
  } else if (type is InterfaceType) {
    return ObjectNode.visit(type);
  } else if (type is TypeParameterType) {
    return ObjectNode._(type, {});
  }
  throw ObjectNodeException('Unsupported type: $type');
}

class ObjectNodeException implements Exception {
  final String message;
  ObjectNodeException(this.message);

  @override
  String toString() => "[ObjectNodeException] $message";
}
