import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_body_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_parameter_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/response_section.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class PathEntity {
  final String path;
  final HttpMethodDiv httpMethodDiv;
  final String? summary;
  final String? description;
  final String operationId;
  final List<String> tagList;

  final RequestBodySection? requestBodySection;
  final RequestParameterSection? requestParameterSection;
  final ResponseSection responseSection;

  PathEntity({
    required this.path,
    required this.httpMethodDiv,
    required this.operationId,
    required this.summary,
    required this.description,
    required this.tagList,
    required this.requestBodySection,
    required this.requestParameterSection,
    required this.responseSection,
  }) {}

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    if (requestBodySection != null) {
      final p = requestBodySection!.toMap();
      if (p != null) {
        m.addAll({"requestBody": p});
      }
    }
    if (requestParameterSection != null) {
      final p = requestParameterSection!.toMap();
      m.addAll({"parameters": p});
    }
    m.addAll({"responses": responseSection.toMap()});
    return m;
  }
}

class PathEntityException implements Exception {
  late final String message;
  PathEntityException(final String message) {
    this.message = "[PathEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

class WithMap {
  final String path;
  final String body;

  WithMap({
    required this.body,
    required this.path,
  });
}
