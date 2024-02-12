import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: multiple method with same tag.
  version: 0.0.1
tags:
  - name: tag_1
    description: tag 1.
paths:
  /multiple-method-with-same-tag:
    get:
      operationId: getMethod
      tags:
        - tag_1
      responses:
        '200':
          description: Successful operation
    post:
      operationId: postMethod
      tags:
        - tag_1
      responses:
        '200':
          description: Successful operation
// */
''',
)
@ConvertTargetClass(
  title: "multiple method with same tag.",
  version: "0.0.1",
  tags: [
    Tag(
      name: "tag_1",
      description: "tag 1.",
    ),
  ],
)
abstract class MultipleMethodWithSameTag {
  const MultipleMethodWithSameTag();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "multiple-method-with-same-tag",
    tags: [
      "tag_1",
    ],
  )
  Future<void> getMethod();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.post,
    pathName: "multiple-method-with-same-tag",
    tags: [
      "tag_1",
    ],
  )
  Future<void> postMethod();
}
