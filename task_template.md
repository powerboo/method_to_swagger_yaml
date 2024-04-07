** Tasks are 100% computer-based. DO NOT simply write long messages to the user to complete tasks. **

# 前提

dart/flutter でライブラリを作成している
dart の abstract class を読み取り、OpenAPI 形式の yaml に変換して出力する

# やること

- ObjectNode クラスの visit コンストラクタを実装する
- ObjectNode クラスの toMap()メソッドを実装する
- visit コンストラクタを適切に実装してテストケースをパスする
- 他のコンストラクタやメソッド、フィールドが必要な場合は適宜追加すること
- 説明等は不要です。Tasks are 100% computer-based. DO NOT simply write long messages to the user to complete tasks.

```yaml
# これはpubspec.yamlの内容
name: method_to_swagger_yaml
description: 'method to swagger yaml.'
version: 0.0.6
repository: https://github.com/powerboo/method_to_swagger_yaml

environment:
  sdk: '>=3.2.4 <4.0.0'

dependencies:
  build: ^2.3.1
  analyzer: '>=6.0.0 <7.0.0'
  source_gen: ^1.5.0
  logging: ^1.2.0
  path: '>1.0.0 <2.3.0-beta'
  yaml_writer: ^2.0.0
  yaml: ^3.1.2
  json_serializable: ^6.7.1

dev_dependencies:
  build_runner: ^2.3.3
  build_test: ^2.2.2
  freezed: ^2.4.7
  freezed_annotation: ^2.4.1
  source_gen_test: ^1.0.6
  test: ^1.21.0
```

# Object Node のコード

- 添付ファイルを参照

# テストコード

- 添付ファイルを参照

# テスト結果

{message}
