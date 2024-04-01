import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:method_to_swagger_yaml/src/entity/output/component/component_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/path_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/tag_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/info_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_body_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_parameter_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/response_section.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml_writer/yaml_writer.dart';

final log = Logger("AbstractClassEntity");

class YamlEntity {
  final ClassElement classElement;
  late final ConvertTargetClass convertTargetClass;
  final List<(ConvertTargetMethod, MethodElement)> listOfConvertTargetMethod =
      [];

  // dump target
  final List<TagEntity> _tagEntityList = [];
  final List<PathEntity> _pathEntityList = [];
  final List<ComponentEntity> _componentEntityList = [];

  void addComponentEntity(ComponentEntity componentEntity) {
    _componentEntityList.add(componentEntity);
  }

  YamlEntity({
    required this.classElement,
  }) {
    // Extract class annotations
    for (final annotation in classElement.metadata) {
      if ('ConvertTargetClass' == annotation.element?.displayName) {
        final value = annotation.computeConstantValue();
        if (value == null) {
          continue;
        }
        final String? title = value.getField('title')?.toStringValue();
        final String? version = value.getField('version')?.toStringValue();
        final String? description =
            value.getField('description')?.toStringValue();
        final List<DartObject>? tags = value.getField('tags')?.toListValue();
        if (title == null) {
          throw InvalidGenerationSourceError(
            "annotation does not have title.",
            element: annotation.element,
          );
        }
        if (version == null) {
          throw InvalidGenerationSourceError(
            "annotation does not have version.",
            element: annotation.element,
          );
        }
        if (tags == null) {
          throw InvalidGenerationSourceError(
            "annotation does not have tags.",
            element: annotation.element,
          );
        }

        final List<Tag> tagList = [];

        // tag from ConvertTargetClass
        for (final t in tags) {
          final name = t.getField("name")?.toStringValue();
          final description = t.getField("description")?.toStringValue();
          final externalDocsVal = t.getField("externalDocs");
          if (name == null) {
            throw InvalidGenerationSourceError(
              "annotation does not have tag name.",
              element: annotation.element,
            );
          }

          if (name == "") {
            throw InvalidGenerationSourceError(
              "tag name does not have empty.",
              element: annotation.element,
            );
          }

          late final ExternalDocs? externalDocs;
          if (externalDocsVal == null && externalDocsVal!.isNull) {
            final description =
                externalDocsVal.getField("description")?.toStringValue();
            final url = externalDocsVal.getField("url")?.toStringValue();
            if (url == null) {
              throw InvalidGenerationSourceError(
                "external doc does not have url.",
                element: annotation.element,
              );
            }
            externalDocs = ExternalDocs(
              url: url,
              description: description,
            );
          } else {
            externalDocs = null;
          }

          // tag
          tagList.add(
            Tag(
              name: name,
              description: description,
              externalDocs: externalDocs,
            ),
          );
        }

        convertTargetClass = ConvertTargetClass(
          title: title,
          version: version,
          description: description,
          tags: tagList,
        );

        break;
      }
    }

    // Extract method annotations
    for (final m in classElement.methods) {
      for (final annotation in m.metadata) {
        if ('ConvertTargetMethod' == annotation.element?.displayName) {
          final value = annotation.computeConstantValue();
          if (value == null) {
            continue;
          }
          final DartObject? httpMethod = value.getField('httpMethod');
          final String? pathName = value.getField('pathName')?.toStringValue();
          final String? summary = value.getField('summary')?.toStringValue();
          final String? operationId =
              value.getField('operationId')?.toStringValue();
          final List<DartObject>? tags = value.getField('tags')?.toListValue();
          final String? responseDescription =
              value.getField('responseDescription')?.toStringValue();
          if (httpMethod == null) {
            throw InvalidGenerationSourceError(
              "httpMethod is null.",
              element: annotation.element,
            );
          }

          if (pathName == null) {
            throw InvalidGenerationSourceError(
              "pathName is null.",
              element: annotation.element,
            );
          }

          if (tags == null) {
            throw InvalidGenerationSourceError(
              "tags is null.",
              element: annotation.element,
            );
          }

          if (responseDescription == null) {
            throw InvalidGenerationSourceError(
              "responseDescription is null.",
              element: annotation.element,
            );
          }

          final variable = httpMethod.variable;
          if (variable == null) {
            throw InvalidGenerationSourceError(
              "variable is null.",
              element: annotation.element,
            );
          }

          final variableElement = variable.type.element;
          if (variableElement == null) {
            throw InvalidGenerationSourceError(
              "variableElement is null.",
              element: annotation.element,
            );
          }

          if (variableElement.name != "HttpMethodDiv") {
            throw InvalidGenerationSourceError(
              "variableElement.name is not HttpMethodDiv.",
              element: annotation.element,
            );
          }

          final div = HttpMethodDiv.from(value: variable.name);

          // tag
          final List<String> tagList = [];
          for (final tag in tags) {
            final t = tag.toStringValue();
            if (t == null) {
              continue;
            }
            tagList.add(t);
          }

          // add
          listOfConvertTargetMethod.add(
            (
              ConvertTargetMethod(
                httpMethod: div,
                pathName: pathName,
                summary: summary,
                operationId: operationId,
                tags: tagList,
                responseDescription: responseDescription,
              ),
              m,
            ),
          );
          break;
        }
      }
    }

    // tag
    for (final tag in convertTargetClass.tags) {
      _tagEntityList.add(
        TagEntity(
          tagName: tag.name,
          description: tag.description,
          externalDocs: tag.externalDocs,
        ),
      );
    }

    // path
    for (final (annotation, method) in listOfConvertTargetMethod) {
      // set operation id
      late String operationId;
      if (annotation.operationId == null) {
        operationId = method.displayName;
      } else {
        operationId = annotation.operationId!;
      }

      final (
        List<ParameterElement> requestParameterQueryList,
        List<ParameterElement> requestParameterPathList,
        List<ParameterElement> requestBodyList,
      ) = convertToPath(
        annotation: annotation,
        parameters: method.parameters,
      );

      // path
      _pathEntityList.add(
        PathEntity(
          httpMethodDiv: annotation.httpMethod,
          summary: annotation.summary,
          path: "/${annotation.pathName}",
          operationId: operationId,
          description: annotation.description,
          tagList: annotation.tags,
          requestBodySection: RequestBodySection(
            methodName: method.name,
            description: annotation.responseDescription,
            required: true,
            listOfParameterType: requestBodyList,
          ),
          requestParameterSection: RequestParameterSection(
            methodName: method.name,
            listOfParameterPathType: requestParameterPathList,
            listOfParameterQueryType: requestParameterQueryList,
          ),
          responseSection: ResponseSection(
            methodElement: method,
            returnType: method.returnType,
          ),
        ),
      );
    }
  }
  String dump() {
    final writer = YamlWriter();

    final Map<String, Object?> m = {};
    m.addAll({"openapi": "3.0.0"});

    final PathsSection _pathsSection =
        PathsSection(pathEntityList: _pathEntityList);
    final InfoSection _infoSection = InfoSection(
      convertTargetClass: convertTargetClass,
    );
    if (_infoSection.toMap() != null) {
      m.addAll(_infoSection.toMap()!);
    }

    final p = _pathsSection.toMap();
    if (p != null) {
      m.addAll(p);
    }

    final components = <String, Object?>{};
    for (final component in componentSectionList) {
      final componentMap = component.toMap();
      if (componentMap != null) {
        components.addAll(componentMap);
      }
    }
    if (components.isNotEmpty) {
      m.addAll({
        "components": {"schemas": components}
      });
    }

    return writer.write(m);
  }
}

class YamlEntityException implements Exception {
  late final String message;
  YamlEntityException(final String message) {
    this.message = "[YamlEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

(
  List<ParameterElement> requestParameterQueryList,
  List<ParameterElement> requestParameterPathList,
  List<ParameterElement> requestBodyList,
) convertToPath({
  required ConvertTargetMethod annotation,
  required List<ParameterElement> parameters,
}) {
  final List<ParameterElement> requestParameterQueryList = [];
  final List<ParameterElement> requestParameterPathList = [];
  final List<ParameterElement> requestBodyList = [];

  switch (annotation.httpMethod) {
    case HttpMethodDiv.delete:
      {
        // parameter
        for (final p in parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestParameterQueryList.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          if (variable.name == RequestParameterDiv.path.toStringValue) {
            requestParameterPathList.add(p);
          } else if (variable.name == RequestParameterDiv.query.toStringValue) {
            requestParameterQueryList.add(p);
          } else {
            requestParameterQueryList.add(p);
          }
        }
      }
      break;
    case HttpMethodDiv.get:
      {
        // parameter
        for (final p in parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestParameterQueryList.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestParameterQueryList.add(p);
            continue;
          }
          if (variable.name == RequestParameterDiv.path.toStringValue) {
            requestParameterPathList.add(p);
          } else if (variable.name == RequestParameterDiv.query.toStringValue) {
            requestParameterQueryList.add(p);
          } else {
            requestParameterQueryList.add(p);
          }
        }
      }
      break;
    case HttpMethodDiv.patch:
      {
        // parameter
        for (final p in parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBodyList.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBodyList.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBodyList.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBodyList.add(p);
            continue;
          }
          if (variable.name == RequestParameterDiv.path.toStringValue) {
            requestParameterPathList.add(p);
          } else if (variable.name == RequestParameterDiv.query.toStringValue) {
            requestParameterQueryList.add(p);
          } else {
            requestBodyList.add(p);
          }
        }
      }
      break;
    case HttpMethodDiv.post:
      {
        // parameter
        for (final p in parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBodyList.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBodyList.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBodyList.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBodyList.add(p);
            continue;
          }
          if (variable.name == RequestParameterDiv.path.toStringValue) {
            requestParameterPathList.add(p);
          } else if (variable.name == RequestParameterDiv.query.toStringValue) {
            requestParameterQueryList.add(p);
          } else {
            requestBodyList.add(p);
          }
        }
      }
      break;
    case HttpMethodDiv.put:
      {
        // parameter
        for (final p in parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBodyList.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBodyList.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBodyList.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBodyList.add(p);
            continue;
          }
          if (variable.name == RequestParameterDiv.path.toStringValue) {
            requestParameterPathList.add(p);
          } else if (variable.name == RequestParameterDiv.query.toStringValue) {
            requestParameterQueryList.add(p);
          } else {
            requestBodyList.add(p);
          }
        }
      }
      break;
    default:
      throw InvalidGenerationSourceError(
        "[convertToPath]un supported HttpMethodDiv.",
        element: null,
      );
  }

  return (
    requestParameterQueryList,
    requestParameterPathList,
    requestBodyList,
  );
}
