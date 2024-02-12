import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: positional argument.
  version: 0.0.1
paths:
  /positional-argument:
    get:
      operationId: getMethod
      parameters:
        - name: positionalStringValue
          in: query
          required: true
          schema:
            type: string
        - name: positionalNullableStringValue
          in: query
          required: false
          schema:
            type: string
        - name: positionalClassValue
          in: query
          required: true
          schema:
            \$ref: '#/components/schemas/GetMethodPositionalClassValue'
        - name: positionalNullableClassValue
          in: query
          required: false
          schema:
            \$ref: '#/components/schemas/GetMethodPositionalNullableClassValue'
      responses:
        '200':
          description: Successful operation
components:
  schemas:
    GetMethodPositionalStringValue:
      type: string
    GetMethodPositionalNullableStringValue:
      type: string
    GetMethodPositionalClassValue:
      type: object
      properties:
        positionalClassValue:
          type: object
          properties:
            value:
              type: string
    GetMethodPositionalNullableClassValue:
      type: object
      properties:
        positionalNullableClassValue:
          type: object
          properties:
            value:
              type: string
// */
''',
)
@ConvertTargetClass(
  title: "positional argument.",
  version: "0.0.1",
)
abstract interface class NamedArgument {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "positional-argument",
  )
  Future<void> getMethod(
    String positionalStringValue,
    String? positionalNullableStringValue,
    PositionalArgument positionalClassValue,
    PositionalArgument? positionalNullableClassValue,
  );
}

class PositionalArgument {
  final String value;
  PositionalArgument({required this.value});
}
