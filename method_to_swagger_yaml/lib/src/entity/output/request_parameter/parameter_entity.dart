import 'package:method_to_swagger_yaml/src/entity/output/component/component_entity.dart';
/*
       - name: status
          in: query
          description: Status values that need to be considered for filter
          required: false
          explode: true
          schema:
            type: string
            default: available
            enum:
              - available
              - pending
              - sold

 */

class ParameterEntity {
  final String name;
  final String inValue;
  final String? description;
  final bool requiredValue;
  final bool explode;
  final ComponentEntity componentEntity;

  ParameterEntity({
    required this.name,
    required this.inValue,
    required this.description,
    required this.requiredValue,
    this.explode = false, // TODO: implements
    required this.componentEntity,
  });

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    m.addAll({"name": name});
    m.addAll({"in": inValue});
    if (description != null) {
      m.addAll({"description": description});
    }
    if (requiredValue == true) {
      m.addAll({"required": requiredValue});
    }
    if (explode == true) {
      m.addAll({"explode": explode});
    }
    m.addAll({"schema": componentEntity.toMap()});
    return m;
  }

  String dump() {
    StringBuffer buffer = StringBuffer();
    return buffer.toString();
  }
}
