/*
      parameters:
 
 */

import 'package:method_to_swagger_yaml/src/entity/output/request_parameter/parameter_entity.dart';

class RequestParameterEntity {
  final List<ParameterEntity> parameterEntityList;

  RequestParameterEntity({
    required this.parameterEntityList,
  });

  List<Map<String, Object?>>? toMap() {
    if (parameterEntityList.isEmpty) {
      return null;
    }
    return parameterEntityList.map((e) => e.toMap()).toList();
  }

  String dump() {
    final StringBuffer buffer = StringBuffer();

    final String base = "      ";
    final String unit = "  ";

    if (parameterEntityList.isNotEmpty) {
      buffer.writeln("${base}parameters:");
      for (final pEntity in parameterEntityList) {
        buffer.writeln("${base}${unit}- name: ${pEntity.name}");
        buffer.writeln("${base}${unit}${unit}in: ${pEntity.inValue}");
        buffer.writeln(
            "${base}${unit}${unit}required: ${pEntity.requiredValue.toString()}");
        buffer.writeln("${base}${unit}${unit}schema:");
        buffer.write(
            "${base}${unit}${unit}${pEntity.componentEntity.dumpTypeOrObject()}");
      }
    }

    return buffer.toString();
  }
}
