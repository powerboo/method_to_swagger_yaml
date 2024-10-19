import 'package:analyzer/dart/element/element.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/schema_section.dart';

class RequestBodySection {
  final String description;
  final bool required;
  final List<RequestContentSection> requestContentList = [];
  final List<ParameterElement> listOfParameterType;
  final String methodName;

  RequestBodySection({
    required this.methodName,
    required this.description,
    required this.required,
    required this.listOfParameterType,
  }) {
    for (final parameter in listOfParameterType) {
      final componentSection = ComponentSection(
        methodName: methodName,
        variableName: parameter.name,
        returnType: parameter.type,
        element: parameter,
      );

      ComponentSection.add(componentSection);

      final schemaSection = SchemaSection(
        componentSection: componentSection,
      );

      requestContentList.add(RequestContentSection(
        schemaSection: schemaSection,
      ));
    }
  }

  Map<String, Object?>? toMap() {
    if (requestContentList.isEmpty) {
      return null;
    }
    final Map<String, Object?> m = {};

    m.addAll({"description": description});
    m.addAll({"required": required});

    final content = Map<String, Object?>();
    for (final e in requestContentList) {
      final r = e.toMap();
      if (r != null) {
        content.addAll(r);
      }
    }
    if (content.isNotEmpty) {
      m.addAll({"content": content});
    }

    return {"requestBody": m};
  }
}

class RequestContentSection {
  final String contentType;
  final SchemaSection schemaSection;

  const RequestContentSection({
    this.contentType = "application/json",
    required this.schemaSection,
  });

  Map<String, Object?>? toMap() {
    final r = schemaSection.toMap();
    if (r == null) {
      return null;
    }
    return {
      contentType: r,
    };
  }
}
