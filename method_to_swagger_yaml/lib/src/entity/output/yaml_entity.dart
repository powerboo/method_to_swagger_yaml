import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:method_to_swagger_yaml/src/entity/output/component/component_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/component/object_node.dart';
import 'package:method_to_swagger_yaml/src/entity/output/path_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/request_body_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/request_parameter/parameter_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/request_parameter_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/response_entity.dart';
import 'package:method_to_swagger_yaml/src/entity/output/tag_entity.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:logging/logging.dart';
// import 'package:source_gen/source_gen.dart';
import 'package:method_to_swagger_yaml/src/builder/generator.dart';

final log = Logger("AbstractClassEntity");

class YamlEntity {
  final ClassElement classElement;
  late final ConvertTargetClass convertTargetClass;
  final List<(ConvertTargetMethod, MethodElement)> listOfConvertTargetMethod = [];

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
        final String? description = value.getField('description')?.toStringValue();
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
            final description = externalDocsVal.getField("description")?.toStringValue();
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
          final String? operationId = value.getField('operationId')?.toStringValue();
          final List<DartObject>? tags = value.getField('tags')?.toListValue();
          final String? responseDescription = value.getField('responseDescription')?.toStringValue();
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

      // convert body
      final (
        requestBody,
        response,
        requestParameter,
      ) = convert(annotation: annotation, method: method);

      // path
      _pathEntityList.add(
        PathEntity(
          httpMethodDiv: annotation.httpMethod,
          summary: annotation.summary,
          path: annotation.pathName,
          operationId: operationId,
          description: annotation.description,
          requestBodyEntity: requestBody,
          responseEntity: response,
          requestParameterEntity: requestParameter,
          tagList: annotation.tags,
        ),
      );
    }
  }
  (
    RequestBodyEntity? requestBodyEntity,
    ResponseEntity responseEntity,
    RequestParameterEntity? requestParameterEntity
  ) convert({
    required ConvertTargetMethod annotation,
    required MethodElement method,
  }) {
    switch (annotation.httpMethod) {
      case HttpMethodDiv.delete:
        return (
          null,
          ResponseEntity(
            description: annotation.responseDescription,
            listOfBodyContent: [],
          ),
          null
        );
      case HttpMethodDiv.get:
        return convertToGet(annotation: annotation, method: method);
      case HttpMethodDiv.patch:
        return (
          null,
          ResponseEntity(
            description: annotation.responseDescription,
            listOfBodyContent: [],
          ),
          null
        );
      case HttpMethodDiv.post:
        return (
          null,
          ResponseEntity(
            description: annotation.responseDescription,
            listOfBodyContent: [],
          ),
          null
        );
      case HttpMethodDiv.put:
        return (
          null,
          ResponseEntity(
            description: annotation.responseDescription,
            listOfBodyContent: [],
          ),
          null
        );
      default:
        throw InvalidGenerationSourceError(
          "[convert]un supported HttpMethodDiv.",
          element: null,
        );
    }

    // ignore: dead_code
    throw InvalidGenerationSourceError(
      "[convert]implements fail.",
      element: null,
    );
  }

// ------------------------------------------------------------
// Arguments not annotated are considered as query parameters by default.
// ------------------------------------------------------------
  (
    RequestBodyEntity? requestBodyEntity,
    ResponseEntity responseEntity,
    RequestParameterEntity? requestParameterEntity
  ) convertToGet({
    required ConvertTargetMethod annotation,
    required MethodElement method,
  }) {
    if (HttpMethodDiv.get != annotation.httpMethod) {
      throw InvalidGenerationSourceError(
        "[convertToGet] http method is not Get.",
        element: null,
      );
    }
    final List<
        (
          ParameterElement,
          RequestParameter?,
          bool annotated,
          bool requiredValue,
        )> listOfAnnotatedParameter = [];

    for (final c in method.children) {
      if (c is! ParameterElement) {
        continue;
      }
      final bool requiredValue = c.type.nullabilitySuffix != NullabilitySuffix.question;

      RequestParameter? requestParameter = null;
      for (final annotation in c.metadata) {
        if ('RequestParameter' == annotation.element?.displayName) {
          final rp = annotation.computeConstantValue();
          if (rp == null) {
            continue;
          }
          final requestParameterDiv = rp.getField("requestParameterDiv");
          final description = rp.getField("description")?.toString();
          final pathStyle = rp.getField("pathStyle");
          final queryStyle = rp.getField("queryStyle");
          final explode = rp.getField("explode")?.toBoolValue();
          if (requestParameterDiv == null) {
            throw InvalidGenerationSourceError(
              "[convertToGet]requestParameterDiv is null.",
              element: null,
            );
          }
          final variable = requestParameterDiv.variable;
          if (variable == null) {
            continue;
          }
          final variableElement = variable.type.element;
          if (variableElement == null) {
            continue;
          }
          if (variableElement.name != "RequestParameterDiv") {
            continue;
          }

          final div = RequestParameterDiv.from(value: variable.name);

          // TODO: implements
          final PathParameterStyleDiv? pStyle = null;
          final QueryParameterStyleDiv? qStyle = null;
          requestParameter = RequestParameter(
            requestParameterDiv: div,
            description: description,
            pathStyle: pStyle,
            queryStyle: qStyle,
            explode: explode,
          );
          break;
        }
      } // end for (annotation in c.metadata)

      // parameter
      listOfAnnotatedParameter.add(
        (
          c,
          requestParameter,
          requestParameter != null,
          requiredValue,
        ),
      );
    } // for (final c in method.children)

    // return type
    /*
  method.returnType;
  // */
    final ResponseEntity responseEntity = ResponseEntity(
      description: annotation.responseDescription,
      listOfBodyContent: [],
    );

    final List<ParameterEntity> parameterEntityList = [];
    for (final (
          ParameterElement pElement,
          RequestParameter? requestParameter,
          bool annotated,
          bool requiredValue,
        ) in listOfAnnotatedParameter) {
      if (annotated) {
        if (requestParameter == null) {
          throw InvalidGenerationSourceError(
            "[convertToGet]annotated is true. But requestParameter is null. please report for us https://github.com/powerboo/method_to_swagger_yaml/issues.",
            element: null,
          );
        }

        final String httpMethod =
            '${annotation.httpMethod.toStringValue[0].toUpperCase()}${annotation.httpMethod.toStringValue.substring(1)}';
        final String methodName = "${method.name[0].toUpperCase()}${method.name.substring(1)}";
        final String parameterName = '${pElement.name[0].toUpperCase()}${pElement.name.substring(1)}';
        final String componentEntityName = "${httpMethod}${methodName}${parameterName}";

        final parameterNode = ObjectNode(
          rank: 1,
          parameterElement: pElement,
        );
        recursiveNode(parameterNode, pElement, 0);

        final componentEntity = ComponentEntity(
          name: componentEntityName,
          objectNode: parameterNode,
        );

        addComponentEntity(componentEntity);

        parameterEntityList.add(
          ParameterEntity(
            name: pElement.name,
            inValue: requestParameter.requestParameterDiv.toStringValue,
            description: requestParameter.description,
            requiredValue: requiredValue,
            componentEntity: componentEntity,
          ),
        );
      } else {
        /*
        final String httpMethod =
            '${annotation.httpMethod.toStringValue[0].toUpperCase()}${annotation.httpMethod.toStringValue.substring(1)}';
            */
        final String methodName = "${method.name[0].toUpperCase()}${method.name.substring(1)}";
        final String parameterName = '${pElement.name[0].toUpperCase()}${pElement.name.substring(1)}';
        // final String componentEntityName = "${httpMethod}${methodName}${parameterName}";
        final String componentEntityName = "${methodName}${parameterName}";

        final parameterNode = ObjectNode(
          rank: 1,
          parameterElement: pElement,
        );
        recursiveNode(parameterNode, pElement, 1);

        final componentEntity = ComponentEntity(
          name: componentEntityName,
          objectNode: parameterNode,
        );

        addComponentEntity(componentEntity);

        // does not annotated
        parameterEntityList.add(
          ParameterEntity(
            name: pElement.name,
            inValue: RequestParameterDiv.query.toStringValue, // default : query
            description: null,
            requiredValue: requiredValue,
            componentEntity: componentEntity,
          ),
        );
      }
    }

    late final RequestParameterEntity? parameterEntity;
    if (parameterEntityList.isNotEmpty) {
      parameterEntity = RequestParameterEntity(
        parameterEntityList: parameterEntityList,
      );
    } else {
      parameterEntity = null;
    }

    return (
      null, // request body is always null
      responseEntity,
      parameterEntity,
    );
  }

  String dump() {
    StringBuffer yamlBuffer = StringBuffer();
    yamlBuffer.writeln("openapi: 3.0.0");
    yamlBuffer.writeln("info:");
    yamlBuffer.writeln("  title: ${convertTargetClass.title}");
    yamlBuffer.writeln("  version: ${convertTargetClass.version}");

    // -------------- tag ----------------
    if (_tagEntityList.isNotEmpty) {
      StringBuffer tag = StringBuffer();
      tag.writeln("tags:");
      for (final t in _tagEntityList) {
        tag.write(t.dump());
      }

      yamlBuffer.write(tag.toString());
    }

    // -------------- path ----------------
    if (_pathEntityList.isNotEmpty) {
      StringBuffer path = StringBuffer();
      // group by path
      final Map<String, List<WithMap>> groupedPaths = {};
      for (final p in _pathEntityList) {
        groupedPaths.putIfAbsent(p.path, () => []).add(p.dumpPath());
      }

      // output by each path
      groupedPaths.forEach((key, value) {
        path.writeln('  /$key:');
        value.forEach((element) {
          path.write(element.body);
        });
      });
      yamlBuffer.writeln("paths:");
      yamlBuffer.write(path.toString());
    }

    if (_componentEntityList.isNotEmpty) {
      StringBuffer component = StringBuffer();
      component.writeln("components:");
      component.writeln("  schemas:");
      for (final t in _componentEntityList) {
        component.write(t.dump());
      }

      yamlBuffer.write(component.toString());
    }

    return yamlBuffer.toString();
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



    /*
    StringBuffer buffer = StringBuffer();
    c.appendToWithoutDelimiters(buffer, withNullability: true);

    print(buffer.toString());
    if (c.type.nullabilitySuffix == NullabilitySuffix.question) {
      print("  - nullabilitySuffix");
    }

    if (c.hasDefaultValue) {
      print("  - hasDefaultValue");
    }
    if (c.isNamed) {
      print("  - isNamed");
    }
    if (c.isOptional) {
      print("  - isOptional");
    }
    if (c.isOptionalNamed) {
      print("  - isOptionalNamed");
    }
    if (c.isPositional) {
      print("  - isPositional");
    }
    if (c.isRequired) {
      print("  - isRequired");
    }
    if (c.isRequiredNamed) {
      print("  - isRequiredNamed");
    }
    if (c.isRequiredPositional) {
      print("  - isRequiredPositional");
    }
    if (c.isCovariant) {
      // class Animal {
      //   void speak(Animal animal) {
      //     print("This animal speaks.");
      //   }
      // }

      // class Dog extends Animal {
      //   // Using the `covariant` keyword to narrow down the parameter type of the overridden method
      //   // from Animal to Dog (a subtype of Animal).
      //   @override
      //   void speak(covariant Dog dog) {
      //     print("The dog barks.");
      //   }
      // }

      // void main() {
      //   Dog dog = Dog();
      //   dog.speak(Dog()); // output "The dog barks."
      // }

      print("  - isCovariant");
    }

    // TODO: implements. get type super member
    if (c.isSuperFormal) {
      // class Person {
      //   String name;
      //   Person(this.name);
      // }

      // class Employee extends Person {
      //   int id;
      //   // `super.name`はsuperフォーマルパラメータです。
      //   // これにより、Employeeのインスタンスを作成する際にPersonのnameフィールドを直接初期化できます。
      //   Employee(this.id, super.name);
      // }

      // void main() {
      //   var employee = Employee(123, 'John Doe');
      //   print(employee.name); // John Doe
      // }
      print("  - isSuperFormal");
    }

    // unnecessary support
    // - annotation target class is abstract.
    // - Can only be used within a constructor in an abstract class.
    // - ConvertTargetMethod annotation does not  support constructor.
    // ex. isInitializingFormal is true.
    // class User {
    //   String name;
    //   int age;
    //   User(this.name, this.age);
    // }
    if (c.isInitializingFormal) {
      print("  - isInitializingFormal");
    }
    // */
