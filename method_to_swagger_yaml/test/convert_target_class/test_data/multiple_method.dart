import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: multiple method.
  version: 0.0.1
paths:
  /multiple-method:
    get:
      operationId: getMethod
      responses:
        '200':
          description: Successful operation
    post:
      operationId: postMethod
      responses:
        '200':
          description: Successful operation
// */
''',
)
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
