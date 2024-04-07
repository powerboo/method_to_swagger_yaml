import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/schema_section.dart';
import 'dart:core';

/*
 */

class ResponseSection {
  late final List<ResponseChildSection> responseChildSectionList;
  late final DartType returnType;
  late final MethodElement methodElement;

  ResponseSection({
    required this.methodElement,
    required this.returnType,
    void Function(ComponentSection)? getComponentSection,
  }) {
    final componentSection = ComponentSection(
      returnType: returnType,
      variableName: "Return",
      methodName: methodElement.name,
    );

    if (getComponentSection != null) {
      getComponentSection(componentSection);
    }
    ComponentSection.add(componentSection);

    final schema = SchemaSection(
      componentSection: componentSection,
    );

    final responseContentSection =
        ResponseContentSection(schemaSection: schema);

    responseChildSectionList = [
      ResponseChildSection(
        statusCode: '200',
        description: 'Successful operation.',
        summary: null,
        responseContentSectionList: [responseContentSection],
      ),
      ResponseChildSection(
        statusCode: '400',
        description: 'operation failure.',
        summary: null,
        responseContentSectionList: [],
      ),
    ];
  }

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    for (final e in responseChildSectionList) {
      m.addAll(e.toMap());
    }

    return {"responses": m};
  }
}

/*
'200':
  description: description
  summary: summary
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/FindPictureId'
    application/xml:
      schema:
        $ref: '#/components/schemas/FindPictureId'
*/
class ResponseChildSection {
  final String statusCode;
  final String description;
  final String? summary;
  final List<ResponseContentSection> responseContentSectionList;

  const ResponseChildSection({
    required this.statusCode,
    required this.description,
    required this.summary,
    required this.responseContentSectionList,
  });

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};

    m.addAll({"description": description});

    if (summary != null) {
      m.addAll({"summary": summary});
    }

    final Map<String, Object?> n = {};
    for (final e in responseContentSectionList) {
      final r = e.toMap();
      if (r != null) {
        n.addAll(r);
      }
    }
    if (n.isNotEmpty) {
      m.addAll({
        "content": n,
      });
    }

    return {"'$statusCode'": m};
  }
}

/*
application/json:
  schema:
    $ref: '#/components/schemas/FindPictureId'
application/json:
  schema:
    type: integer
*/
class ResponseContentSection {
  final String contentType;
  final SchemaSection schemaSection;

  const ResponseContentSection({
    this.contentType = "application/json",
    required this.schemaSection,
  });

  Map<String, Object?>? toMap() {
    final r = schemaSection.toMap();
    if (r == null) {
      return null;
    }

    return {
      contentType: schemaSection.toMap(),
    };
  }
}

/*
X-RateLimit-Remaining:
  schema:
    type: integer
  description: The number of requests left for the time window.
*/
class ResponseHeaderSection {
  final String name;
  final String description;
  final SchemaSection? schemaSection;

  ResponseHeaderSection({
    required this.name,
    required this.description,
    required this.schemaSection,
  });

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};

    m.addAll({"description": description});

    if (schemaSection != null) {
      final r = schemaSection!.toMap();
      if (r != null) {
        m.addAll(r);
      }
    }

    return {name: m};
  }
}
