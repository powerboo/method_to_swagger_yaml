import 'package:method_to_swagger_yaml/src/entity/output/path_entity.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class PathsSection {
  final List<PathEntity> pathEntityList;

  PathsSection({
    required this.pathEntityList,
  });

  Map<String, Object?>? toMap() {
    if (pathEntityList.isEmpty) {
      return null;
    }

    final pl = pathEntityList.map((e) => e.path).toSet().toList();

    Map<String, Object?> map = {};

    for (final path in pl) {
      // pathに当てはまるmap取り出す
      final samePathList = pathEntityList.where((e) => e.path == path).toList();

      // select pathSectionDiv ,count(*) group by pathSectionDiv
      final divCounts = Map<HttpMethodDiv, int>();
      for (final item in samePathList) {
        divCounts.update(item.httpMethodDiv, (value) => ++value,
            ifAbsent: () => 1);
      }
      for (final dc in divCounts.entries) {
        final count = dc.value;
        if (count > 1) {
          throw PathsSectionException(
              "div is duplicate. path: $path, div: ${dc.key}, count: $count");
        }
      }

      final Map<String, Object?> m = {};
      for (final l in samePathList) {
        switch (l.httpMethodDiv) {
          case HttpMethodDiv.get:
            {
              m.addAll({"get": l.toMap()});
            }
            break;
          case HttpMethodDiv.post:
            {
              m.addAll({"post": l.toMap()});
            }
            break;
          case HttpMethodDiv.delete:
            {
              m.addAll({"delete": l.toMap()});
            }
            break;
          case HttpMethodDiv.put:
            {
              m.addAll({"put": l.toMap()});
            }
            break;
          case HttpMethodDiv.patch:
            {
              m.addAll({"patch": l.toMap()});
            }
            break;
          default:
            throw PathsSectionException("un supported PathSectionDiv.");
        }
      }

      map.addAll({
        path: m,
      });
    }

    return {
      "paths": map,
    };
  }
}

class PathsSectionException implements Exception {
  late final String message;
  PathsSectionException(final String message) {
    this.message = "[PathsSectionException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
