// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SwaggerYamlGenerator
// **************************************************************************

/*
openapi: 3.0.0
info:
  title: sample.
  version: 0.0.1
paths:
  /sample-path:
    get:
      operationId: getMethod
      parameters:
        - name: namedStringValue
          in: query
          required: true
          schema:
            type: string
        - name: namedClassValue
          in: query
          required: true
          schema:
            $ref: '#/components/schemas/GetMethodNamedClassValue'
        - name: requiredNamedNullableClassValue
          in: query
          required: false
          schema:
            $ref: '#/components/schemas/GetMethodRequiredNamedNullableClassValue'
      responses:
        '200':
          description: Successful operation
components:
  schemas:
    GetGetMethodNamedStringValue:
      type: string
    GetMethodNamedClassValue:
      type: object
      properties:
        namedClassValue:
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
*/
