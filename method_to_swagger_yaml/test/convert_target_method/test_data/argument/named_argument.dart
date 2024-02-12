import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: named argument.
  version: 0.0.1
paths:
  /named-argument:
    get:
      operationId: getMethod
      parameters:
        - name: namedStringValue
          in: query
          required: true
          schema:
            type: string
        - name: namedNullableStringValue
          in: query
          required: false
          schema:
            type: string
        - name: namedClassValue
          in: query
          required: true
          schema:
            \$ref: '#/components/schemas/GetMethodNamedClassValue'
        - name: namedNullableClassValue
          in: query
          required: false
          schema:
            \$ref: '#/components/schemas/GetMethodNamedNullableClassValue'
        - name: requiredNamedStringValue
          in: query
          required: true
          schema:
            type: string
        - name: requiredNamedNullableStringValue
          in: query
          required: false
          schema:
            type: string
        - name: requiredNamedClassValue
          in: query
          required: true
          schema:
            \$ref: '#/components/schemas/GetMethodRequiredNamedClassValue'
        - name: requiredNamedNullableClassValue
          in: query
          required: false
          schema:
            \$ref: '#/components/schemas/GetMethodRequiredNamedNullableClassValue'
      responses:
        '200':
          description: Successful operation
components:
  schemas:
    GetGetMethodNamedStringValue:
      type: string
    GetGetMethodNamedNullableStringValue:
      type: string
    GetMethodNamedClassValue:
      type: object
      properties:
        namedClassValue:
          type: object
          properties:
            value:
              type: string
    GetMethodNamedNullableClassValue:
      type: object
      properties:
        namedNullableClassValue:
          type: object
          properties:
            value:
              type: string
    GetMethodRequiredNamedStringValue:
      type: string
    GetMethodRequiredNamedNullableStringValue:
      type: string
    GetMethodRequiredNamedClassValue:
      type: object
      properties:
        requiredNamedClassValue:
          type: object
          properties:
            value:
              type: string
    GetMethodRequiredNamedNullableClassValue:
      type: object
      properties:
        requiredNamedNullableClassValue:
          type: object
          properties:
            value:
              type: string
// */
''',
)
@ConvertTargetClass(
  title: "named argument.",
  version: "0.0.1",
)
abstract interface class NamedArgument {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "named-argument",
  )
  Future<void> getMethod({
    @RequestParameter() String namedStringValue,
    @RequestParameter() String? namedNullableStringValue,
    ClassValue namedClassValue,
    ClassValue? namedNullableClassValue,
    required String requiredNamedStringValue,
    required String? requiredNamedNullableStringValue,
    required ClassValue requiredNamedClassValue,
    required ClassValue? requiredNamedNullableClassValue,
  });
}

class ClassValue {
  final value;
  const ClassValue({
    required this.value,
  });
}

/*
    dynamicValue,
    String stringValue,
    String? nullableStringValue,
    ClassValue classValue,
    ClassValue? nullableClassValue, {
    namedDynamicValue,
    String namedStringValue,
    String? namedNullableStringValue,
    ClassValue namedClassValue,
    ClassValue? namedNullableClassValue,
    namedDynamicValueHasValue = 1,
    String namedStringValueHasValue = "val",
    String? namedNullableStringValueHasValue = null,
    ClassValue namedClassValueHasValue = const ClassValue(),
    ClassValue? namedNullableClassValueHasValue = null,
    required String requiredNamedStringValue,
    required String? requiredNamedNullableStringValue,
    required ClassValue requiredNamedClassValue,
    required ClassValue? requiredNamedNullableClassValue,

   */
