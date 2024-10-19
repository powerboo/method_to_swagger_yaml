import 'dart:async';

import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:sample_pj/repository/object/freezed_class.dart';
import 'package:sample_pj/repository/object/skip_target.dart';
import 'package:sample_pj/repository/object/val/freezed_id.dart';

@ConvertTargetClass(
  title: "sample v2.",
  version: "0.0.1",
)
abstract interface class V2Repository {
  @ConvertTargetMethod(
    httpMethod: HttpMethodDiv.get,
    pathName: "v2-sample-path",
  )
  Future<void> v2GetMethod({
    @RequestParameter(
      requestParameterDiv: RequestParameterDiv.path,
      useToString: true,
    )
    required FreezedId v2FreezedId,
    String v2NamedStringValue,
    V2ClassValue v2NamedClassValue,
    required V2ClassValue? v2RequiredNamedNullableClassValue,
    required FreezedClass v2FreezedClass,
    required SkipTarget include,
    @IgnoreField() required SkipTarget ignore,
  });
}

class V2ClassValue {
  final String value;
  const V2ClassValue({
    required this.value,
  });
}
