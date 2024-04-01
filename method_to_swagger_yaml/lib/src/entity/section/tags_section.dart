import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class TagsSection {
  final ConvertTargetClass convertTargetClass;
  TagsSection({
    required this.convertTargetClass,
  });

  Map<String, Object?>? toMap() {
    if (convertTargetClass.tags.isEmpty) {
      return null;
    }
    final List<Map<String, Object?>> map = [];
    for (final tag in convertTargetClass.tags) {
      final Map<String, Object?> t = {};

      t.addAll({"name": tag.name});

      if (tag.description != null) {
        t.addAll({"description": tag.description});
      }

      if (tag.externalDocs != null) {
        t.addAll({"externalDocs": tag.externalDocs});
      }

      map.add(t);
    }

    return {
      "tags": map,
    };
  }
}
