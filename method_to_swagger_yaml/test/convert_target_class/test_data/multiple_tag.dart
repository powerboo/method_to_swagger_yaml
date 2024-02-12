import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: multiple tag.
  version: 0.0.1
tags:
  - name: tag_1
    description: tag 1.
  - name: tag_2
    description: tag 2.
paths:
  /multiple-tag:
    get:
      operationId: getMethod
      tags:
        - tag_1
        - tag_2
      responses:
        '200':
          description: Successful operation
// */
''',
)
@ConvertTargetClass(
  title: "multiple tag.",
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
abstract class MultipleTag {
  const MultipleTag();
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "multiple-tag",
    tags: [
      "tag_1",
      "tag_2",
    ],
  )
  Future<void> getMethod();
}
