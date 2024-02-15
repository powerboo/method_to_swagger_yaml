import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class YamlBuilder extends Builder {
  final GeneratorForAnnotation _generator;

  @override
  final Map<String, List<String>> buildExtensions = {
    '.dart': ['.yaml']
  };

  YamlBuilder(
    this._generator,
  );
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;

    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final lib = await buildStep.resolver.libraryFor(buildStep.inputId, allowSyntaxErrors: true);

    final libraryReader = LibraryReader(lib);

    String createdUnit = await _generator.generate(libraryReader, buildStep);
    createdUnit = createdUnit.trim();
    if (createdUnit.isEmpty) {
      return;
    }

    final contentBuffer = StringBuffer();
    contentBuffer.writeln(createdUnit);

    final outputId = buildStep.allowedOutputs.first;
    final content = contentBuffer.toString();

    await buildStep.writeAsString(outputId, content);
  }
}

class YamlBuilderException implements Exception {
  late final String message;
  YamlBuilderException(final String message) {
    this.message = "[YamlBuilderException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
