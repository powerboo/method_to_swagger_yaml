import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';

class SchemaSection {
  final ComponentSection componentSection;
  SchemaSection({required this.componentSection});

  Map<String, Object?>? toMap() {
    final r = componentSection.toMap();
    if (r == null) {
      return null;
    }
    return {
      "schema": componentSection.toRefPath(),
    };
  }
}
