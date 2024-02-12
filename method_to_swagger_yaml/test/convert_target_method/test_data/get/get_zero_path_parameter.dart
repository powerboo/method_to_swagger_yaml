import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: path parameter annotation is zero.
  version: 0.0.1
paths:
  /zero-tag:
    get:
      operationId: getMethod
      responses:
        '200':
          description: Successful operation
// */
''',
)
@ConvertTargetClass(
  title: "path parameter annotation is zero.",
  version: "0.0.1",
)
abstract class GetZeroPathParameter {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "path-parameter-annotation-is-zero",
  )
  Future<void> getMethod({
    required String value,
  });
}
