import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "zero tag.",
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
abstract class ZeroTag {
  const ZeroTag();
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "zero-tag",
  )
  Future<void> getMethod();
}
