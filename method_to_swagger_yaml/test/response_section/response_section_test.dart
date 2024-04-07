import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/response_section.dart';
import 'package:test/test.dart';

void main() {
  test("response section test", () async {
    final testClassCode = '''
class TestClass {
  String name;
  int age;
  List<String> hobbies;

  TestClass(this.name, this.age, this.hobbies);
}
abstract interface class TestClassRepository {
  Future<List<TestClass>> all(
    int cursor,
    int length,
  );
}
      ''';

    final main = await resolveSource(testClassCode, (Resolver resolver) {
      return resolver.libraries.toList();
    });

    final els = main.map((e) => e.getClass("TestClassRepository"));

    final List<ResponseSection> responseSectionList = [];
    ComponentSection? componentSection;
    for (final e in els) {
      if (e == null) {
        continue;
      }
      for (final method in e.methods) {
        responseSectionList.add(ResponseSection(
          methodElement: method,
          returnType: method.returnType,
          getComponentSection: (c) {
            componentSection = c;
          },
        ));
      }
      break;
    }
    if (responseSectionList.isEmpty) {
      expect(true, false);
      return;
    }
    if (responseSectionList.length != 1) {
      expect(true, false);
      return;
    }
    if (componentSection == null) {
      expect(true, false);
      return;
    }
    final responseSection = responseSectionList.first;
    expect(responseSection.methodElement.name, "all");
    expect(responseSection.returnType.getDisplayString(withNullability: true),
        "Future<List<TestClass>>");

    final m = componentSection?.toMap();
    if (m == null) {
      expect(true, false);
      return;
    }
    expect(m, {
      "AllReturn": {
        "type": "array",
        "items": {
          "type": "object",
          "required": ["age", "hobbies", "name"],
          "properties": {
            "name": {"type": "string"},
            "age": {"type": "integer"},
            "hobbies": {
              "type": "array",
              "items": {"type": "string"}
            },
          },
        },
      }
    });
  });
}
