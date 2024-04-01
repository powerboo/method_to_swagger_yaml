import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class InfoSection {
  final ConvertTargetClass convertTargetClass;
  InfoSection({
    required this.convertTargetClass,
  });

  Map<String, Object?>? toMap() {
    Map<String, Object?> m = {};
    m.addAll({"title": convertTargetClass.title});
    m.addAll({"version": convertTargetClass.version});
    if (convertTargetClass.description != null) {
      final d = convertTargetClass.description;
      if (d != null) {
        m.addAll({"description": d});
      }
    }

    return {"info": m};
  }
}
