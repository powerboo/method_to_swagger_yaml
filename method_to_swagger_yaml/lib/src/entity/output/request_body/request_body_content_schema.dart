import 'package:freezed_annotation/freezed_annotation.dart';

/*
          application/json:
            schema:
              $ref: '#/components/schemas/Pet'
          application/xml:
            schema:
              oneOf:
                - $ref: '#/components/schemas/Pet'
                - $ref: '#/components/schemas/Pet'
          application/x-www-form-urlencoded:
            schema:
              anyOf:
                - $ref: '#/components/schemas/Pet'
                - $ref: '#/components/schemas/Pet'
                - $ref: '#/components/schemas/Pet'
 */

class RequestBodyContentSchema {
  String path;
  RequestBodyContentSchema({
    required this.path,
  });

  String dump() {
    StringBuffer buffer = StringBuffer();
    final String base = "                ";
    final String unit = "  ";
    buffer.writeln("${base}${unit}\$ref: ${path}");

    return buffer.toString();
  }
}

class RequestBodyContentSchemaException implements Exception {
  late final String message;
  RequestBodyContentSchemaException(final String message) {
    this.message = "[RequestBodyContentSchemaException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
