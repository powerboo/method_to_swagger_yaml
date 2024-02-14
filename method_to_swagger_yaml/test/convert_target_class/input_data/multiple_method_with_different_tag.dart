import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "multiple method with different tag.",
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
abstract class MultipleMethodDifferentTag {
  const MultipleMethodDifferentTag();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "multiple-method-with-different-tag",
    tags: [
      "tag_1",
    ],
  )
  Future<void> getMethod();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.post,
    pathName: "multiple-method-with-different-tag",
    tags: [
      "tag_2",
    ],
  )
  Future<void> postMethod();
}
