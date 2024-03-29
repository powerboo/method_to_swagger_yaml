import 'dart:async';

import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "sample.",
  version: "0.0.1",
)
abstract interface class NamedArgument {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "sample-path",
  )
  Future<void> getMethod({
    @RequestParameter() String namedStringValue,
    ClassValue namedClassValue,
    required ClassValue? requiredNamedNullableClassValue,
  });
}

class ClassValue {
  final String value;
  const ClassValue({
    required this.value,
  });
}
