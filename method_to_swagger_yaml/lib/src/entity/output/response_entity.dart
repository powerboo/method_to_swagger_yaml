/*
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                type: array items:
                  $ref: '#/components/schemas/Pet'          
            application/xml:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Pet'
 */

import 'package:method_to_swagger_yaml/src/entity/output/request_body/body_content.dart';

class ResponseEntity {
  final String description;
  final List<BodyContent> listOfBodyContent;
  ResponseEntity({
    required this.description,
    required this.listOfBodyContent,
  });

  Map<String, Object?> toMap() {
    return {};
  }

  String dump() {
    StringBuffer buffer = StringBuffer();
    final String base = "      ";
    final String unit = "  ";

    buffer.writeln("${base}responses:");
    buffer.writeln("${base}${unit}'200':");
    buffer.writeln("${base}${unit}${unit}description: ${description}");

    // content
    if (listOfBodyContent.isNotEmpty) {
      buffer.writeln("${base}${unit}${unit}content:");
      for (final content in listOfBodyContent) {
        buffer.write(content.dump());
      }
    }

    return buffer.toString();
  }
}

class ResponseEntityException implements Exception {
  late final String message;
  ResponseEntityException(final String message) {
    this.message = "[ResponseEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
