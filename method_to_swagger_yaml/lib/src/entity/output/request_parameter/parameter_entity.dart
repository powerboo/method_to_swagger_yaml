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

  String dump() {
    StringBuffer buffer = StringBuffer();
    return buffer.toString();
  }
}
