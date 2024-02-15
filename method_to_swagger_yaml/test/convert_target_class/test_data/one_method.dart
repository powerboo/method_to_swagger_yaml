import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
// import 'package:source_gen_test/annotations.dart';

/*
@ShouldGenerate('''
openapi: 3.0.0
info:
  title: one method.
  version: 0.0.1
paths:
  /one-method:
    get:
      operationId: oneMethod
      responses:
        '200':
          description: Successful operation
''')
// */
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
