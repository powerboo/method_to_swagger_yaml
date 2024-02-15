import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow("tag name does not have empty.")
@ConvertTargetClass(
  title: "tag name does not have empty.",
  version: "0.0.1",
  tags: [
    Tag(
      name: "",
    ),
  ],
)
abstract class TagNameDoesNotEmpty {
  const TagNameDoesNotEmpty();
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "path",
  )
  Future<void> getMethod();
}
