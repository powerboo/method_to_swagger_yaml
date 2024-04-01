import 'package:method_to_swagger_yaml/src/entity/output/component/object_node.dart';

/*
    ${name}:
      type: object
      properties:
        id:
          type: object
          properties:
            id: 
              type: string
        petId:
          type: integer
          format: int64
        quantity:
          type: integer
          format: int32
        shipDate:
          type: string
        status:
          type: string
          description: Order Status
          example: approved
          enum:
            - placed
            - approved
            - delivered
        complete:
          type: boolean

 */
class ComponentEntity {
  final String name;
  final ObjectNode objectNode;

  ComponentEntity({
    required this.name,
    required this.objectNode,
  });

  bool get isObject {
    return objectNode.isObject;
  }

  Map<String, Object?> toMap() {
    final Map<String, Object?> m = {};
    if (!isObject) {
      m.addAll({"type": ""});
    } else {
      m.addAll(objectNode.toMap());
    }

    return {name: m};
  }

  Map<String, Object?> toRefPath() {
    return {"\$ref": "'#/components/schemas/${name}'"};
  }

  String componentPath() {
    StringBuffer buffer = StringBuffer();
    String unit = "  ";
    buffer.writeln("${unit}\$ref: '#/components/schemas/${name}'");
    return buffer.toString();
  }

  String dumpTypeOrObject() {
    StringBuffer buffer = StringBuffer();
    if (isObject) {
      buffer.write(componentPath());
    } else {
      buffer.write(objectNode.dump());
    }

    return buffer.toString();
  }

  String dump() {
    StringBuffer buffer = StringBuffer();
    final String base = "    ";

    buffer.writeln("${base}${name}:");
    buffer.write("${objectNode.dump(base: base)}");
    return buffer.toString();
  }
}

class ComponentEntityException implements Exception {
  late final String message;
  ComponentEntityException(final String message) {
    this.message = "[ComponentEntityException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
