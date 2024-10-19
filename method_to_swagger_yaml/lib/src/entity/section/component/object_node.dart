import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

class ObjectNode {
  final DartType type;
  final Map<String, ObjectNode> properties;
  final ObjectNode? itemNode;
  final Map<String, DartType> typeArguments;

  ObjectNode._(this.type, this.properties,
      {this.itemNode, this.typeArguments = const {}});

  bool get isNullable {
    return type.isDartCoreNull ||
        type.nullabilitySuffix == NullabilitySuffix.question;
  }

  factory ObjectNode.visit(final DartType type,
      {Map<String, DartType> typeArguments = const {}}) {
    final properties = <String, ObjectNode>{};

    if (type is InterfaceType) {
      if (type.element.name == 'DateTime') {
        return ObjectNode._(type, properties);
      }

      for (final entry
          in _getPropertiesFromInterfaceType(type, typeArguments).entries) {
        if (_hasIgnoreFieldInYamlAnnotation(entry.value.type.element)) {
          continue;
        }
        properties[entry.key] = entry.value;
      }

      // Handling for freezed classes
      if (type.element.constructors.any((c) => c.isFactory)) {
        // ミックスインのプロパティを取得
        for (final mixin in type.element.mixins) {
          properties
              .addAll(_getPropertiesFromInterfaceType(mixin, typeArguments));
        }
      }
      return ObjectNode._(type, properties, typeArguments: typeArguments);
    } else if (type is ParameterizedType && type.isDartCoreList) {
      final itemType = type.typeArguments.first;
      final itemNode = _createObjectNodeForType(itemType, typeArguments);
      return ObjectNode._(type, properties, itemNode: itemNode);
    } else if (type is TypeParameterType) {
      final bound = type.bound;
      final actualType = typeArguments[type.element.name] ?? bound;
      return ObjectNode.visit(actualType, typeArguments: typeArguments);
    } else {
      return ObjectNode._(type, properties, typeArguments: typeArguments);
    }
  }

  Element? getFieldElement(String fieldName) {
    if (type is InterfaceType) {
      final interfaceType = type as InterfaceType;
      return interfaceType.element
              .lookUpGetter(fieldName, interfaceType.element.library) ??
          interfaceType.element.getField(fieldName);
    }
    return null;
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
    } else if (type.element is EnumElement) {
      final enumElement = type.element as EnumElement;
      final enumValues =
          enumElement.fields.where((e) => e.isEnumConstant).toList();

      final Map<String, int> enumValuesWithArguments = {};
      for (final field in enumValues) {
        final constantValue = field.computeConstantValue();
        final reader = ConstantReader(constantValue);
        enumValuesWithArguments[field.name] =
            reader.objectValue.getField('index')?.toIntValue() ?? 0;
      }

      List<int> result = [];
      for (final e in enumValuesWithArguments.values) {
        result.add(e);
      }

      return {
        'type': 'integer',
        'enum': result,
      };
    } else if (type is ParameterizedType && type.isDartCoreList) {
      if (itemNode == null) {
        if (type is InterfaceType) {
          final t = type as InterfaceType;
          final node = ObjectNode.visit(t.typeArguments.first,
              typeArguments: typeArguments);
          final n = node.toMap();
          if (n == null) {
            return null;
          }
          return {
            'type': 'array',
            'items': n,
          };
        }
        return null;
      }
      final itemMap = itemNode?.toMap(
          parentTypeArguments: {...typeArguments, ...parentTypeArguments});
      if (itemMap == null) {
        return null;
      }

      return {
        'type': 'array',
        'items': itemMap,
      };
    } else if (type is InterfaceType) {
      if (type.isDartAsyncFuture ||
          type.isDartAsyncFutureOr ||
          type.isDartAsyncStream) {
        final Map<String, dynamic> result = {};
        for (final t in (type as InterfaceType).typeArguments) {
          final node = _createObjectNodeForType(t, {...typeArguments});
          if (node == null) {
            continue;
          }
          final n = node.toMap();
          if (n != null) {
            result.addAll(n);
          }
        }
        return result;
      }

      final map = <String, dynamic>{
        'type': 'object',
        'properties': {},
      };

      final requiredProperties = <String>[];

      final allArgs = {...typeArguments, ...parentTypeArguments};

      for (final entry in properties.entries) {
        print('Processing field: ${entry.key}'); // デバッグ出力
        print(
            'Has IgnoreFieldInYaml annotation: ${_hasIgnoreFieldInYamlAnnotation(_getFieldElement(type, entry.key))}'); // デバッグ出力

        // IgnoreFieldInYaml アノテーションがついているフィールドをスキップ
        if (_hasIgnoreFieldInYamlAnnotation(entry.value.type.element) ||
            _hasIgnoreFieldInYamlAnnotation(
                _getFieldElement(type, entry.key))) {
          print('Skipping field: ${entry.key}'); // デバッグ出力
          continue;
        }

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
          final element = getFieldElement(entry.key);
          if (element == null) {
            continue;
          }
          if (_hasIgnoreFieldInYamlAnnotation(element)) {
            continue;
          }
          map['properties'][entry.key.toSnakeCase()] = value;

          if (!entry.value.isNullable) {
            final element = getFieldElement(entry.key);
            if (element == null) {
              continue;
            }
            if (_hasIgnoreFieldInYamlAnnotation(element)) {
              continue;
            }
            requiredProperties.add(entry.key.toSnakeCase());
          }
        } else {
          for (final arg in allArgs.entries) {
            final node = ObjectNode.visit(arg.value);
            final nodeToMap = node.toMap();
            if (nodeToMap != null) {
              final element = getFieldElement(entry.key);
              if (element == null) {
                continue;
              }
              if (_hasIgnoreFieldInYamlAnnotation(element)) {
                continue;
              }

              map['properties'][entry.key.toSnakeCase()] = nodeToMap;
              if (!entry.value.isNullable) {
                final element = getFieldElement(entry.key);
                if (element == null) {
                  continue;
                }
                if (_hasIgnoreFieldInYamlAnnotation(element)) {
                  continue;
                }
                requiredProperties.add(entry.key.toSnakeCase());
              }
            }
          }
        }
      }

      requiredProperties
          .sort(); // Add this line to sort the required properties

      if (requiredProperties.isNotEmpty) {
        map['required'] = requiredProperties;
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
    if (_hasIgnoreFieldInYamlAnnotation(field)) continue;

    final fieldType = field.type;
    final fieldNode = _createObjectNodeForType(fieldType, typeArguments);
    if (fieldNode != null) {
      properties[field.name] = fieldNode;
    }
  }

  // クラスのプロパティを取得
  for (final accessor in type.element.accessors) {
    if (_hasIgnoreFieldInYamlAnnotation(accessor)) {
      continue;
    }
    if (accessor.isGetter &&
        !accessor.isStatic &&
        accessor.name != 'runtimeType' &&
        accessor.name != 'hashCode' &&
        accessor.name != 'copyWith' &&
        !properties.containsKey(accessor.name)) {
      final fieldName = accessor.name;
      final fieldNode =
          _createObjectNodeForType(accessor.returnType, typeArguments);
      if (fieldNode != null) {
        properties[fieldName] = fieldNode;
      }
    }
  }

  return properties;
}

ObjectNode? _createObjectNodeForType(
    DartType type, Map<String, DartType> typeArguments) {
  if (_hasIgnoreFieldInYamlAnnotation(type.element)) {
    return null;
  }
  if (type.isDartAsyncFuture ||
      type.isDartAsyncFutureOr ||
      type.isDartAsyncStream) {
    final itemNode = _createObjectNodeForType(type, typeArguments);
    return ObjectNode._(type, {}, itemNode: itemNode);
  } else if (type.isDartCoreString ||
      type.isDartCoreBool ||
      type.isDartCoreInt ||
      type.isDartCoreDouble) {
    return ObjectNode._(type, {});
  } else if (type.element is EnumElement) {
    return ObjectNode._(type, {});
  } else if (type is ParameterizedType && type.isDartCoreList) {
    final itemType = type.typeArguments.first;
    if (_hasIgnoreFieldInYamlAnnotation(itemType.element)) {
      return null;
    }
    final itemNode = _createObjectNodeForType(itemType, typeArguments);
    if (itemNode == null) {
      return null;
    }
    return ObjectNode._(type, {}, itemNode: itemNode);
  } else if (type is InterfaceType) {
    final visitedTypeArguments = {};
    for (var i = 0; i < type.typeArguments.length; i++) {
      if (_hasIgnoreFieldInYamlAnnotation(type.typeArguments[i].element)) {
        continue;
      }
      visitedTypeArguments[type.element.typeParameters[i].name] =
          type.typeArguments[i];
    }

    return ObjectNode.visit(type,
        typeArguments: {...typeArguments, ...visitedTypeArguments});
  } else if (type is TypeParameterType) {
    if (_hasIgnoreFieldInYamlAnnotation(type.element)) {
      return null;
    }
    final actualType = typeArguments[type.element.name];
    if (actualType != null && actualType is! TypeParameterType) {
      if (_hasIgnoreFieldInYamlAnnotation(actualType.element)) {
        return null;
      }

      return _createObjectNodeForType(actualType, typeArguments);
    } else {
      if (_hasIgnoreFieldInYamlAnnotation(type.element)) {
        return null;
      }
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

bool _hasIgnoreFieldInYamlAnnotation(Element? element) {
  if (element == null) return false;
  return element.metadata
      .any((e) => e.element?.displayName == 'IgnoreFieldInYaml');
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

// 新しいヘルパーメソッドを追加
Element? _getFieldElement(DartType type, String fieldName) {
  if (type is InterfaceType) {
    return type.element.getField(fieldName);
  }
  return null;
}
