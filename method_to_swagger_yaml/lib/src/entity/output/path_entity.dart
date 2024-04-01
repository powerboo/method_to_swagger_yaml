import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_parameter_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_body_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/response_section.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class PathEntity {
  final String path;
  final HttpMethodDiv httpMethodDiv;

  final String operationId;
  final String? summary;
  final String? description;
  final List<String> tagList;
  final RequestParameterSection? requestParameterSection;
  final RequestBodySection? requestBodySection;
  final ResponseSection responseSection;

  PathEntity({
    required this.operationId,
    required this.summary,
    required this.description,
    required this.tagList,

    // v2
    required this.path,
    required this.httpMethodDiv,
    required this.responseSection,
    required this.requestParameterSection,
    required this.requestBodySection,
  }) {}

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    m.addAll({"operationId": operationId});
    if (summary != null) {
      m.addAll({"summary": summary});
    }
    if (description != null) {
      m.addAll({"description": description});
    }
    if (tagList.isNotEmpty) {
      m.addAll({"tags": tagList});
    }
    if (requestParameterSection != null) {
      m.addAll(requestParameterSection!.toMap());
    }
    if (requestBodySection != null) {
      final result = requestBodySection!.toMap();
      if (result != null) {
        m.addAll(result);
      }
    }
    m.addAll(responseSection.toMap());

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
