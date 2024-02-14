import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "one method.",
  version: "0.0.1",
)
abstract class OneMethod {
  const OneMethod();

  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "one-method",
  )
  Future<void> oneMethod();
}
