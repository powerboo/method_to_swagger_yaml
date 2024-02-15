import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';

@ConvertTargetClass(
  title: "positional argument.",
  version: "0.0.1",
)
abstract interface class PositionalArgumentClass {
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
