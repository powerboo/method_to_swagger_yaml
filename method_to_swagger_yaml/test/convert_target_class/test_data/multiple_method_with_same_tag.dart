import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

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
