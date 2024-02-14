import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "multiple method.",
  version: "0.0.1",
)
abstract class MultipleMethod {
  const MultipleMethod();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "multiple-method",
  )
  Future<void> getMethod();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.post,
    pathName: "multiple-method",
  )
  Future<void> postMethod();
}
