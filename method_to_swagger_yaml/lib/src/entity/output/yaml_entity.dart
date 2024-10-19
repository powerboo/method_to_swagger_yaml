import 'dart:collection';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:method_to_swagger_yaml/src/entity/output/component/component_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/path_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/tag_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/section/component/component_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/info_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_body_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/request_parameter_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/paths_section/body/response_section.dart';
import 'package:method_to_swagger_yaml/src/entity/section/tags_section.dart';
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
      DartType? returnType = getFutureGenericType(method);
      if (returnType == null) {
        continue;
      }
      final (
        List<ParameterElement> listOfParameterPath,
        List<ParameterElement> listOfParameterQuery,
        List<ParameterElement> listOfParameterBody,
      ) = getParameterTypes(
        annotation.httpMethod,
        method,
      );

      // path
      _pathEntityList.add(
        PathEntity(
          summary: annotation.summary,
          operationId: operationId,
          description: annotation.description,
          httpMethodDiv: annotation.httpMethod,
          path: "/${annotation.pathName}",
          tagList: annotation.tags,
          responseSection: ResponseSection(
            methodElement: method,
            returnType: returnType,
          ),
          requestParameterSection: RequestParameterSection(
            methodName: method.name,
            listOfParameterPathType: listOfParameterPath,
            listOfParameterQueryType: listOfParameterQuery,
          ),
          requestBodySection: RequestBodySection(
            listOfParameterType: listOfParameterBody,
            methodName: method.name,
            description: annotation.responseDescription,
            required: false,
          ),
        ),
      );
    }
  }

  String dump() {
    // init
    final infoSectionMap =
        InfoSection(convertTargetClass: convertTargetClass).toMap();
    final tagsSectionMap =
        TagsSection(convertTargetClass: convertTargetClass).toMap();
    final pathsSection = PathsSection(pathEntityList: _pathEntityList).toMap();

    // write
    final yamlWriter = YamlWriter(allowUnquotedStrings: true);
    final Map<String, Object?> yamlObject = {
      "openapi": "3.0.0",
    };

    if (infoSectionMap != null) {
      yamlObject.addAll(infoSectionMap);
    }
    if (tagsSectionMap != null) {
      yamlObject.addAll(tagsSectionMap);
    }
    if (pathsSection != null) {
      yamlObject.addAll(pathsSection);
    }

    if (componentSectionList.isNotEmpty) {
      final Map<String, Object?> component = {};
      for (final e in componentSectionList) {
        final r = e.toMap();
        if (r != null) {
          component.addAll(r);
        }
      }
      // ソートする
      final SplayTreeMap<String, Object?> sortedMap =
          SplayTreeMap<String, Object?>.from(component);

      final Map<String, Object?> sortedComponent =
          Map<String, Object?>.from(sortedMap);

      yamlObject.addAll({
        "components": {"schemas": sortedComponent}
      });
    }

    final String yaml = yamlWriter.write(yamlObject);
    return yaml;
  }
}

// MethodElementから戻り値の型を取得し、Futureの型引数を解析する関数
DartType? getFutureGenericType(MethodElement method) {
  DartType returnType = method.returnType;

  // returnTypeがFutureかどうかを確認
  if (returnType.isDartAsyncFuture || returnType.isDartAsyncFutureOr) {
    // FutureまたはFutureOrの場合、型引数を取得
    var typeArguments = (returnType as ParameterizedType).typeArguments;
    if (typeArguments.isNotEmpty) {
      // Future<T>のTを返す
      return typeArguments.first;
    }
  }
  return null;
}

// MethodElementの引数からList<DartType>を取り出す関数
(
  List<ParameterElement> requestParameterPath,
  List<ParameterElement> requestParameterQuery,
  List<ParameterElement> requestBody,
) getParameterTypes(
  HttpMethodDiv div,
  MethodElement method,
) {
  final List<ParameterElement> requestParameterPath = [];
  final List<ParameterElement> requestParameterQuery = [];
  final List<ParameterElement> requestBody = [];
  switch (div) {
    case HttpMethodDiv.delete:
      {
        for (final p in method.parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestParameterQuery.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestParameterQuery.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestParameterQuery.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestParameterQuery.add(p);
            continue;
          }
          if (RequestParameterDiv.path.toStringValue == variable.name) {
            requestParameterPath.add(p);
          } else if (RequestParameterDiv.query.toStringValue == variable.name) {
            requestParameterQuery.add(p);
          } else {
            throw InvalidGenerationSourceError(
              "[getParameterTypes][delete]un supported RequestParameterDiv.",
              element: null,
            );
          }
        }
      }
      break;
    case HttpMethodDiv.get:
      {
        for (final p in method.parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestParameterQuery.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestParameterQuery.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestParameterQuery.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestParameterQuery.add(p);
            continue;
          }
          if (RequestParameterDiv.path.toStringValue == variable.name) {
            requestParameterPath.add(p);
          } else if (RequestParameterDiv.query.toStringValue == variable.name) {
            requestParameterQuery.add(p);
          } else {
            throw InvalidGenerationSourceError(
              "[getParameterTypes][get]un supported RequestParameterDiv.",
              element: null,
            );
          }
        }
      }
      break;
    case HttpMethodDiv.patch:
      {
        for (final p in method.parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBody.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBody.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBody.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBody.add(p);
            continue;
          }
          if (RequestParameterDiv.path.toStringValue == variable.name) {
            requestParameterPath.add(p);
          } else if (RequestParameterDiv.query.toStringValue == variable.name) {
            requestParameterQuery.add(p);
          } else {
            throw InvalidGenerationSourceError(
              "[getParameterTypes][get]un supported RequestParameterDiv.",
              element: null,
            );
          }
        }
      }
      break;
    case HttpMethodDiv.post:
      {
        for (final p in method.parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBody.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBody.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBody.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBody.add(p);
            continue;
          }
          if (RequestParameterDiv.path.toStringValue == variable.name) {
            requestParameterPath.add(p);
          } else if (RequestParameterDiv.query.toStringValue == variable.name) {
            requestParameterQuery.add(p);
          } else {
            throw InvalidGenerationSourceError(
              "[getParameterTypes][get]un supported RequestParameterDiv.",
              element: null,
            );
          }
        }
      }
      break;
    case HttpMethodDiv.put:
      {
        for (final p in method.parameters) {
          final annotations = p.metadata
              .where((e) => e.element?.displayName == "RequestParameter");
          if (annotations.isEmpty) {
            requestBody.add(p);
            continue;
          }
          final annotation = annotations.first;
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            requestBody.add(p);
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          if (requestParameterDiv == null) {
            requestBody.add(p);
            continue;
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            requestBody.add(p);
            continue;
          }
          if (RequestParameterDiv.path.toStringValue == variable.name) {
            requestParameterPath.add(p);
          } else if (RequestParameterDiv.query.toStringValue == variable.name) {
            requestParameterQuery.add(p);
          } else {
            throw InvalidGenerationSourceError(
              "[getParameterTypes][get]un supported RequestParameterDiv.",
              element: null,
            );
          }
        }
      }
      break;
    default:
      throw InvalidGenerationSourceError(
        "[getParameterTypes]un supported HttpMethodDiv.",
        element: null,
      );
  }

  return (
    requestParameterPath,
    requestParameterQuery,
    requestBody,
  );
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
