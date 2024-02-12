import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: multiple method with different tag.
  version: 0.0.1
tags:
  - name: tag_1
    description: tag 1.
  - name: tag_2
    description: tag 2.
paths:
  /multiple-method-with-complex-tag:
    get:
      operationId: getMethod
      tags:
        - tag_1
      responses:
        '200':
          description: Successful operation
// */
''',
  expectedLogItems: [
    '[AbstractClassEntity][tagList]enclosingElement.name is not ConvertTargetClass.name[ShouldGenerate]',
    '[AbstractClassEntity][tagList]externalDocs is not null.But url is null.'
  ],
)
@ConvertTargetClass(
  title: "multiple method with complex tag.",
  version: "0.0.1",
  tags: [
    Tag(
      name: "tag_1",
      description: "tag 1.",
    ),
    Tag(
      name: "tag_2",
      description: "tag 2.",
    ),
  ],
)
abstract class MultipleMethodComplexTag {
  const MultipleMethodComplexTag();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "multiple-method-with-complex-tag",
    tags: [
      "tag_1",
    ],
  )
  Future<void> getMethod();

  Future<void> postMethod();
}
