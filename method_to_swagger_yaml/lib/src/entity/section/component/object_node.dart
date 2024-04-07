import 'package:analyzer/dart/element/type.dart';

class ObjectNode {
  final DartType type;
  final Map<String, ObjectNode> properties;
  final ObjectNode? itemNode;
  final Map<String, DartType> typeArguments;

  ObjectNode._(this.type, this.properties,
      {this.itemNode, this.typeArguments = const {}});

  factory ObjectNode.visit(final DartType type,
      {Map<String, DartType> typeArguments = const {}}) {
    final properties = <String, ObjectNode>{};

    if (type is InterfaceType) {
      if (type.element.name == 'DateTime') {
        return ObjectNode._(type, properties);
      }

      properties.addAll(_getPropertiesFromInterfaceType(type, typeArguments));

      // Handling for freezed classes
      if (type.element.constructors.any((c) => c.isFactory)) {
        // ミックスインのプロパティを取得
        for (final mixin in type.element.mixins) {
          properties
              .addAll(_getPropertiesFromInterfaceType(mixin, typeArguments));
        }
      }
    } else if (type is ParameterizedType && type.isDartCoreList) {
      final itemType = type.typeArguments.first;
      final itemNode = _createObjectNodeForType(itemType, typeArguments);
      return ObjectNode._(type, properties, itemNode: itemNode);
    } else if (type is TypeParameterType) {
      final bound = type.bound;
      final actualType = typeArguments[type.element.name] ?? bound;
      return ObjectNode.visit(actualType, typeArguments: typeArguments);
    }

    return ObjectNode._(type, properties, typeArguments: typeArguments);
  }

  Map<String, dynamic>? toMap(
      {Map<String, DartType> parentTypeArguments = const {}}) {
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
        'items': itemNode?.toMap(parentTypeArguments: {
              ...typeArguments,
              ...parentTypeArguments
            }) ??
            {'type': 'object'},
      };
    } else if (type is InterfaceType) {
      final map = <String, dynamic>{
        'type': 'object',
        'properties': {},
      };

      final allArgs = {...typeArguments, ...parentTypeArguments};

      for (final entry in properties.entries) {
        final value = entry.value.toMap(parentTypeArguments: allArgs);
        if (value != null) {
          // Avoid adding @JsonKey properties and freezed properties
          if (entry.key.startsWith('is') ||
              entry.key == 'length' ||
              entry.key == 'list' ||
              entry.key == 'copyWith' ||
              entry.key == 'runtimeType' ||
              entry.key == 'hashCode') {
            continue;
          }
          map['properties'][entry.key.toSnakeCase()] = value;
        } else {
          for (final arg in allArgs.entries) {
            final node = ObjectNode.visit(arg.value);
            final nodeToMap = node.toMap();
            if (nodeToMap != null) {
              map['properties'][entry.key.toSnakeCase()] = nodeToMap;
            }
          }
        }
      }

      return map;
    }

    return null;
  }
}

Map<String, ObjectNode> _getPropertiesFromInterfaceType(
    InterfaceType type, Map<String, DartType> typeArguments) {
  final properties = <String, ObjectNode>{};

  for (final field in type.element.fields) {
    if (field.isStatic) continue;
    if (field.name == 'hashCode') continue;

    final fieldType = field.type;
    final fieldNode = _createObjectNodeForType(fieldType, typeArguments);
    properties[field.name] = fieldNode;
  }

  // クラスのプロパティを取得
  for (final accessor in type.element.accessors) {
    if (accessor.isGetter &&
        !accessor.isStatic &&
        accessor.name != 'runtimeType' &&
        accessor.name != 'hashCode' &&
        accessor.name != 'copyWith' &&
        !properties.containsKey(accessor.name)) {
      final fieldName = accessor.name;
      final fieldNode =
          _createObjectNodeForType(accessor.returnType, typeArguments);
      properties[fieldName] = fieldNode;
    }
  }

  return properties;
}

ObjectNode _createObjectNodeForType(
    DartType type, Map<String, DartType> typeArguments) {
  if (type.isDartCoreString ||
      type.isDartCoreBool ||
      type.isDartCoreInt ||
      type.isDartCoreDouble) {
    return ObjectNode._(type, {});
  } else if (type is ParameterizedType && type.isDartCoreList) {
    final itemType = type.typeArguments.first;
    final itemNode = _createObjectNodeForType(itemType, typeArguments);
    return ObjectNode._(type, {}, itemNode: itemNode);
  } else if (type is InterfaceType) {
    final visitedTypeArguments = {
      for (var i = 0; i < type.typeArguments.length; i++)
        type.element.typeParameters[i].name: type.typeArguments[i]
    };
    return ObjectNode.visit(type,
        typeArguments: {...typeArguments, ...visitedTypeArguments});
  } else if (type is TypeParameterType) {
    final actualType = typeArguments[type.element.name];
    if (actualType != null && actualType is! TypeParameterType) {
      return _createObjectNodeForType(actualType, typeArguments);
    } else {
      return ObjectNode._(type, {});
    }
  }
  throw ObjectNodeException('Unsupported type: $type');
}

class ObjectNodeException implements Exception {
  final String message;
  ObjectNodeException(this.message);

  @override
  String toString() => "[ObjectNodeException] $message";
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
