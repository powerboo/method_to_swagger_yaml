import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  '''
/*
openapi: 3.0.0
info:
  title: multiple method with different tag.
  version: 0.0.1
paths:
  /multiple-method-with-complex-tag:
    get:
      operationId: getMethod
      tags:
        - tag_1
      responses:
        '200':
          description: Successful operation
// */
''',
  expectedLogItems: [
    '[AbstractClassEntity][tagList]enclosingElement.name is not ConvertTargetClass.name[ShouldGenerate]',
    '[AbstractClassEntity][tagList]externalDocs is not null.But url is null.'
  ],
)
@ConvertTargetClass(
  title: "multiple annotation in single file 1.",
  version: "0.0.1",
)
class MultipleAnnotationInSingleFile_1 {
  const MultipleAnnotationInSingleFile_1();
}

@ConvertTargetClass(
  title: "multiple annotation in single file 2.",
  version: "0.0.1",
)
class MultipleAnnotationInSingleFile_2 {
  const MultipleAnnotationInSingleFile_2();
}
