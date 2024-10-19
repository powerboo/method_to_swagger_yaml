import 'dart:async';

import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:sample_pj/repository/object/freezed_class.dart';
import 'package:sample_pj/repository/object/skip_target.dart';
import 'package:sample_pj/repository/object/val/freezed_id.dart';

@ConvertTargetClass(
  title: "sample.",
  version: "0.0.1",
)
abstract interface class V1Repository {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "v1-sample-path",
  )
  Future<void> v1GetMethod({
    @RequestParameter(
      requestParameterDiv: RequestParameterDiv.path,
      useToString: true,
    )
    required FreezedId v1FreezedId,
    String v1NamedStringValue,
    ClassValue v1NamedClassValue,
    required ClassValue? v1RequiredNamedNullableClassValue,
    required FreezedClass v1FreezedClass,
    required SkipTarget include,
    @IgnoreField() required SkipTarget ignore,
  });
}

class ClassValue {
  final String value;
  const ClassValue({
    required this.value,
  });
}
