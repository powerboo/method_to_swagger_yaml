import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

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
