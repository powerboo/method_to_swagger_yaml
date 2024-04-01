import 'package:method_to_swagger_yaml/src/entity/output/request_body/body_content.dart';
import 'package:source_gen/source_gen.dart';

/*
      requestBody:
        description: Create a new pet in the store
        required: true
        content:
*/

class RequestBodyEntity {
  final String? description;
  final List<BodyContent> listOfContent;
  final bool requestBodyRequired;

  RequestBodyEntity({
    this.description,
    required this.listOfContent,
    this.requestBodyRequired = false,
  }) {
    if (listOfContent.isEmpty) {
      throw InvalidGenerationSourceError(
          "request body must contain at least one content.");
    }
  }

  Map<String, Object?> toMap() {
    return {};
  }

  String dump() {
    StringBuffer buffer = StringBuffer();
    final String base = "      ";
    final String unit = "  ";

    buffer.writeln("${base}requestBody:");

    // description
    if (description != null) {
      buffer.writeln("${base}${unit}description: ${description}");
    }

    // required
    if (requestBodyRequired) {
      buffer.writeln("${base}${unit}required: true");
    }

    // content
    buffer.writeln("${base}${unit}content: ${description}");
    for (final content in listOfContent) {
      buffer.write(content.dump());
    }

    return buffer.toString();
  }
}

class RequestBodyEntityException implements Exception {
  late final String message;
  RequestBodyEntityException(final String message) {
    this.message = "[RequestBodyEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
