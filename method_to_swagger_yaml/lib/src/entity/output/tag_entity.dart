import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

class TagEntity {
  final String tagName;
  final String? description;
  final ExternalDocs? externalDocs;

  TagEntity({
    required this.tagName,
    required this.description,
    required this.externalDocs,
  });

  String dump() {
    StringBuffer buffer = StringBuffer();
    buffer.writeln("  - name: ${tagName}");
    if (description != null) {
      buffer.writeln("    description: ${description}");
    }
    return buffer.toString();
  }

  String dumpInPath() {
    return "        - ${tagName}";
  }
}

class TagEntityException implements Exception {
  late final String message;
  TagEntityException(final String message) {
    this.message = "[TagEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
