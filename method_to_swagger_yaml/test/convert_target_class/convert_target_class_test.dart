import 'package:method_to_swagger_yaml/src/generator/swagger_yaml_generator.dart';
import 'package:method_to_swagger_yaml_annotation/method_to_swagger_yaml_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

// ------------------------------------------------------------
// convert_target_class
// ------------------------------------------------------------
void main() async {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  final path = p.join('test', 'convert_target_class', 'test_data');

  // annotated variable
  final annotatedVariable = await initializeLibraryReaderForDirectory(
    path,
    'annotated_variable.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    annotatedVariable,
    SwaggerYamlGenerator(),
  );

  // only support abstract class
  final onlySupportAbstractClass = await initializeLibraryReaderForDirectory(
    path,
    'only_support_abstract_class.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    onlySupportAbstractClass,
    SwaggerYamlGenerator(),
  );

  // does not have method
  final doesNotHaveMethod = await initializeLibraryReaderForDirectory(
    path,
    'does_not_have_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    doesNotHaveMethod,
    SwaggerYamlGenerator(),
  );

  // does not have annotated method
  final doesNotHaveAnnotatedMethod = await initializeLibraryReaderForDirectory(
    path,
    'does_not_have_annotated_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    doesNotHaveAnnotatedMethod,
    SwaggerYamlGenerator(),
  );

  // one method
  final oneMethod = await initializeLibraryReaderForDirectory(
    path,
    'one_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    oneMethod,
    SwaggerYamlGenerator(),
  );

  // multiple method
  final multipleMethod = await initializeLibraryReaderForDirectory(
    path,
    'multiple_method.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    multipleMethod,
    SwaggerYamlGenerator(),
  );

  // multiple method with same tag
  final multipleMethodWithSameTag = await initializeLibraryReaderForDirectory(
    path,
    'multiple_method_with_same_tag.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    multipleMethodWithSameTag,
    SwaggerYamlGenerator(),
  );

  // multiple method with different tag
  final multipleMethodWithDifferentTag = await initializeLibraryReaderForDirectory(
    path,
    'multiple_method_with_different_tag.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    multipleMethodWithDifferentTag,
    SwaggerYamlGenerator(),
  );

  // zero tag
  final zeroTag = await initializeLibraryReaderForDirectory(
    path,
    'zero_tag.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    zeroTag,
    SwaggerYamlGenerator(),
  );

  // one tag
  final singleTag = await initializeLibraryReaderForDirectory(
    path,
    'single_tag.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    singleTag,
    SwaggerYamlGenerator(),
  );

  // multiple tag
  final multipleTag = await initializeLibraryReaderForDirectory(
    path,
    'multiple_tag.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    multipleTag,
    SwaggerYamlGenerator(),
  );

  // tag name is empty
  final tagNameIsEmpty = await initializeLibraryReaderForDirectory(
    path,
    'tag_name_is_empty.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    tagNameIsEmpty,
    SwaggerYamlGenerator(),
  );

  // -------------- convert_target_method ----------------
}
// テスト
// # 正常系
// - ConvertTargetClassアノテーションについて
//   × nameが特殊文字(後でやる)
//   × クラスにメソッドが一つ(ConvertTargetMethodが0件)
//   × クラスにメソッドが複数(ConvertTargetMethodが0件)

// - ConvertTargetMethodアノテーションについて
//   HttpMethodDiv.get
//   - pathParameterアノテーション
//     0件
//     一つ
//     複数
//   - queryParameterアノテーション
//     0件
//     一つ
//     複数
//   HttpMethodDiv.post
//   - pathParameterアノテーション
//   - queryParameterアノテーション
//   HttpMethodDiv.put
//   - pathParameterアノテーション
//   - queryParameterアノテーション
//   HttpMethodDiv.patch
//   - pathParameterアノテーション
//   - queryParameterアノテーション
//   HttpMethodDiv.delete
//   - pathParameterアノテーション
//   - queryParameterアノテーション
//   path名がempty
//   path名が特殊文字
//   tagが0件
//   tagが一つ(ConvertTargetClassに存在する)
//   tagが複数(ConvertTargetClassに存在する)
//   summaryがnull
//   summaryがある
//   operationIdがnull
//   operationIdがある
//   descriptionがnull
//   descriptionがある
//   メソッドの引数
//   - named
//   - primitive
//   - freezed
//   - enum
//   メソッドの戻り値
//   - Future
//   - dynamic
//   - void
//   - enum
//   - primitive
//   - freezed
// - ConvertTargetMethodアノテーションについて
//   tagが一つ(ConvertTargetClassに存在しない)
//   tagが複数(ConvertTargetClassに存在しない)
//   同名tagが複数(ConvertTargetClassに存在する)
//   同名tagが複数(ConvertTargetClassに存在しない)
