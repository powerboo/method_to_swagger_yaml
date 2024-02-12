import 'package:method_to_swagger_yaml/src/entity/output/request_body/request_body_content_schema.dart';
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

class BodyContent {
  final String mediaType = 'application/json';
  final List<RequestBodyContentSchema> listOfContentSchema;
  final String? oneOf;
  final String? anyOf;

  BodyContent({
    // required this.mediaType, TODO: implements
    required this.listOfContentSchema,
    this.oneOf,
    this.anyOf,
  }) {
    if (listOfContentSchema.isEmpty) {
      throw RequestBodyContentException("request body content must contain at least one content.");
    }
    if (oneOf != null && anyOf != null) {
      throw RequestBodyContentException("Both 'oneOf' and 'anyOf' cannot be used at the same time.");
    }
  }

  String dump() {
    StringBuffer buffer = StringBuffer();
    final String base = "          ";
    final String unit = "  ";

    buffer.writeln("${base}${mediaType}");
    buffer.writeln("${base}${unit}schema:");
    if (oneOf == null && anyOf == null) {
      for (final sch in listOfContentSchema) {
        buffer.write(sch.dump());
      }
    }

    if (oneOf != null) {
      throw RequestBodyContentException("un implements.");
    }

    if (anyOf != null) {
      throw RequestBodyContentException("un implements.");
    }

    return buffer.toString();
  }
}

class RequestBodyContentException implements Exception {
  late final String message;
  RequestBodyContentException(final String message) {
    this.message = "[RequestBodyContentException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
