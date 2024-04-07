import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/object_node.dart';

void main() {
  group('ObjectNode tests', () {
    test('Complex type', () async {
      final testClassCode = '''
        class TestClass {
          String name;
          int age;
          List<String> hobbies;
          
          TestClass(this.name, this.age, this.hobbies);
        }
      ''';

      final main = await resolveSource(testClassCode, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("TestClass"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "name": {"type": "string"},
          "age": {"type": "integer"},
          "hobbies": {
            "type": "array",
            "items": {"type": "string"}
          }
        }
      });
    });
    test('Complex type Include DateTime', () async {
      final testClassCode = '''
        class TestClass {
          String name;
          int age;
          DateTime dateTime;
          List<String> hobbies;
          
          TestClass(this.name, this.age, this.dateTime, this.hobbies);
        }
      ''';

      final main = await resolveSource(testClassCode, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("TestClass"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "name": {"type": "string"},
          "age": {"type": "integer"},
          "hobbies": {
            "type": "array",
            "items": {"type": "string"}
          },
          "dateTime": {"type": "string", "format": "date-time"}
        }
      });
    });
    test('String type', () async {
      final testStringCode = '''
    final String value = "";
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final stringType = typeProvider.stringType;

      final result = ObjectNode.visit(stringType).toMap();

      expect(result, {'type': 'string'});
    });
    test('bool type', () async {
      final testStringCode = '''
    final bool value = false;
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final boolType = typeProvider.boolType;

      final result = ObjectNode.visit(boolType).toMap();

      expect(result, {'type': 'boolean'});
    });

    test('int type', () async {
      final testStringCode = '''
    final int value = 0;
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final intType = typeProvider.intType;

      final result = ObjectNode.visit(intType).toMap();

      expect(result, {'type': 'integer'});
    });

    test('double type', () async {
      final testStringCode = '''
    final double value = 0.0;
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final doubleType = typeProvider.doubleType;

      final result = ObjectNode.visit(doubleType).toMap();

      expect(result, {'type': 'number'});
    });

    test('Void type', () async {
      final testStringCode = '''
    final double value = 0.0;
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final doubleType = typeProvider.voidType;

      final result = ObjectNode.visit(doubleType).toMap();

      expect(result, null);
    });

    test('Dynamic type', () async {
      final testStringCode = '''
    final double value = 0.0;
  ''';
      final resolveResult =
          await resolveSource(testStringCode, (Resolver resolver) {
        return resolver;
      });

      final libraryElement = await resolveResult.libraries.first;
      final typeProvider = libraryElement.typeProvider;
      final doubleType = typeProvider.dynamicType;

      final result = ObjectNode.visit(doubleType).toMap();

      expect(result, null);
    });

    test('single freezed class', () async {
      final List<String> filePaths = [
        'test/object_node/test_data/val/freezed_id.dart',
        'test/object_node/test_data/val/freezed_id.g.dart',
        'test/object_node/test_data/val/freezed_id.freezed.dart'
      ];
      final Map<String, String> resolveSourceMap = {};
      for (final filePath in filePaths) {
        resolveSourceMap["main|$filePath"] = File(filePath).readAsStringSync();
      }

      final main = await resolveSources(resolveSourceMap, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("FreezedId"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        expect(false, true);
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "freezedId": {"type": "string"},
        }
      });
    });
    test('nested freezed class', () async {
      final List<String> filePaths = [
        'test/object_node/test_data/freezed_class.dart',
        'test/object_node/test_data/freezed_class.g.dart',
        'test/object_node/test_data/freezed_class.freezed.dart',
        'test/object_node/test_data/val/freezed_id.dart',
        'test/object_node/test_data/val/freezed_id.g.dart',
        'test/object_node/test_data/val/freezed_id.freezed.dart',
        'test/object_node/test_data/val/freezed_value.dart',
        'test/object_node/test_data/val/freezed_value.g.dart',
        'test/object_node/test_data/val/freezed_value.freezed.dart'
      ];
      final Map<String, String> resolveSourceMap = {};
      for (final filePath in filePaths) {
        resolveSourceMap["main|$filePath"] = File(filePath).readAsStringSync();
      }

      final main = await resolveSources(resolveSourceMap, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("FreezedClass"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        expect(false, true);
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "freezedId": {
            "type": "object",
            "properties": {
              "freezedId": {"type": "string"}
            }
          },
          "freezedValue": {
            "type": "object",
            "properties": {
              "value": {"type": "integer"}
            }
          },
        }
      });
    });
    test('single json serializable class', () async {
      final List<String> filePaths = [
        'test/object_node/test_data/json_serializable_class.dart',
        'test/object_node/test_data/json_serializable_class.g.dart',
      ];
      final Map<String, String> resolveSourceMap = {};
      for (final filePath in filePaths) {
        resolveSourceMap["main|$filePath"] = File(filePath).readAsStringSync();
      }

      final main = await resolveSources(resolveSourceMap, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("JsonSerializableClass"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        expect(false, true);
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "value": {
            "type": "string",
          },
        }
      });
    });

    test('list json serializable class', () async {
      final List<String> filePaths = [
        'test/object_node/test_data/target_list_class.dart',
        'test/object_node/test_data/target_list_class.freezed.dart',
      ];
      final Map<String, String> resolveSourceMap = {};
      for (final filePath in filePaths) {
        resolveSourceMap["main|$filePath"] = File(filePath).readAsStringSync();
      }

      final main = await resolveSources(resolveSourceMap, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("TargetListClass"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        expect(false, true);
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
          },
          "targetList": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "name": {"type": "string"}
              }
            }
          }
        }
      });
    });

    test('object json', () async {
      final List<String> filePaths = [
        'test/object_node/test_data/list_of_val/list_of_val.dart',
        'test/object_node/test_data/list_of_val/list_of_val.freezed.dart',
        'test/object_node/test_data/list_of_val/list_of_val.g.dart',
      ];
      final Map<String, String> resolveSourceMap = {};
      for (final filePath in filePaths) {
        resolveSourceMap["main|$filePath"] = File(filePath).readAsStringSync();
      }

      final main = await resolveSources(resolveSourceMap, (Resolver resolver) {
        return resolver.libraries.toList();
      });

      final els = main.map((e) => e.getClass("ListOfValue"));

      ObjectNode? objectNode;
      for (final e in els) {
        if (e == null) {
          continue;
        }
        objectNode = ObjectNode.visit(e.thisType);
        break;
      }

      if (objectNode == null) {
        expect(false, true);
        return;
      }

      expect(objectNode.toMap(), {
        "type": "object",
        "properties": {
          "listOfValue": {
            'type': 'object',
            'properties': {
              "listOfAny": {
                "type": "array",
                "items": {
                  "type": "object",
                  "properties": {
                    'sortNum': {
                      'type': 'object',
                      'properties': {
                        'value': {'type': 'integer'}
                      }
                    },
                    "sortKey": {
                      "type": "object",
                      "properties": {
                        "value": {"type": "string"}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      });
    });
  });
}
