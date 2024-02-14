import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

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
