import 'package:method_to_swagger_yaml/src/entity/output/request_body_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/request_parameter_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/response_entity.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class PathEntity {
  final String path;
  final HttpMethodDiv httpMethodDiv;
  final String? summary;
  final String? description;
  final String operationId;
  final RequestBodyEntity? requestBodyEntity;
  final ResponseEntity responseEntity;
  final RequestParameterEntity? requestParameterEntity;
  final List<String> tagList;

  PathEntity({
    required this.path,
    required this.httpMethodDiv,
    required this.operationId,
    required this.summary,
    required this.description,
    required this.requestBodyEntity,
    required this.responseEntity,
    required this.requestParameterEntity,
    required this.tagList,
  }) {}

  String _postDump() {
    StringBuffer buffer = StringBuffer();
    const String base = "    ";
    const String unit = "  ";
    buffer.writeln("${base}post:");
    buffer.writeln("${base}${unit}operationId: ${operationId}");

    if (tagList.isNotEmpty) {
      buffer.writeln("${base}${unit}tags:");
      for (final tag in tagList) {
        buffer.writeln("${base}${unit}${unit}- ${tag}");
      }
    }

    if (requestParameterEntity != null) {
      buffer.write(requestParameterEntity!.dump());
    }

    if (requestBodyEntity != null) {
      buffer.write(requestBodyEntity!.dump());
    }

    buffer.write(responseEntity.dump());

    return buffer.toString();
  }

  String _getDump() {
    StringBuffer buffer = StringBuffer();
    const String base = "    ";
    const String unit = "  ";
    buffer.writeln("${base}get:");
    buffer.writeln("${base}${unit}operationId: ${operationId}");

    if (tagList.isNotEmpty) {
      buffer.writeln("${base}${unit}tags:");
      for (final tag in tagList) {
        buffer.writeln("${base}${unit}${unit}- ${tag}");
      }
    }

    if (requestParameterEntity != null) {
      buffer.write(requestParameterEntity!.dump());
    }

    if (requestBodyEntity != null) {
      buffer.write(requestBodyEntity!.dump());
    }

    buffer.write(responseEntity.dump());

    return buffer.toString();
  }

  String _deleteDump() {
    return '''
''';
  }

  WithMap dumpPath() {
    switch (httpMethodDiv) {
      case HttpMethodDiv.delete:
        return WithMap(body: _deleteDump(), path: path);
      case HttpMethodDiv.get:
        return WithMap(body: _getDump(), path: path);
      case HttpMethodDiv.patch:
        throw PathEntityException("un implements HttpMethodDiv.patch");
      case HttpMethodDiv.post:
        return WithMap(body: _postDump(), path: path);
      case HttpMethodDiv.put:
        throw PathEntityException("un implements HttpMethodDiv.put");
      default:
        throw PathEntityException("un supported HttpMethodDiv.");
    }

    // ignore: dead_code
    throw PathEntityException("implements fail.");
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
