import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/object_node.dart';

void main() {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  group('ObjectNode tests', () {
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

    test('list type', () async {});

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
            "properties": {
              "items": {"type": "string"}
            }
          }
        }
      });
    });
  });
}
