import 'dart:async';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:method_to_swagger_yaml/src/builder/generated_output.dart';
import 'package:method_to_swagger_yaml/src/builder/generator.dart';
import 'package:method_to_swagger_yaml/src/builder/library.dart';

class YamlBuilder implements Builder {
  final String extension;

  final Generator _generator;

  @override
  final Map<String, List<String>> buildExtensions;

  YamlBuilder(
    this._generator, {
    this.extension = '.yaml',
  }) : buildExtensions = {
          '.dart': [extension]
        };

  @override
  Future<void> build(BuildStep buildStep) async {
    // final resolver = buildStep.resolver;

    /*
    if (_generator is GeneratorForAnnotation &&
        !(await _hasAnyTopLevelAnnotations(
          buildStep.inputId,
          resolver,
          buildStep,
        ))) {
      return;
    }
    // */

    final lib = await buildStep.resolver.libraryFor(buildStep.inputId, allowSyntaxErrors: false);
    await _generateForLibrary(lib, buildStep);
  }

  Future<void> _generateForLibrary(
    LibraryElement library,
    BuildStep buildStep,
  ) async {
    final generatedOutputs = await _generate(library, [_generator], buildStep).toList();

    if (generatedOutputs.isEmpty) {
      return;
    }
    final outputId = buildStep.allowedOutputs.first;
    final contentBuffer = StringBuffer();

    for (var item in generatedOutputs) {
      contentBuffer.writeln(item.output);
    }

    var genPartContent = contentBuffer.toString();

    await buildStep.writeAsString(outputId, genPartContent);
  }

  Stream<GeneratedOutput> _generate(
    LibraryElement library,
    List<Generator> generators,
    BuildStep buildStep,
  ) async* {
    final libraryReader = LibraryReader(library);
    for (var i = 0; i < generators.length; i++) {
      final gen = generators[i];
      var msg = 'Running $gen';
      if (generators.length > 1) {
        msg = '$msg - ${i + 1} of ${generators.length}';
      }
      log.fine(msg);
      var createdUnit = await gen.generate(libraryReader, buildStep);

      if (createdUnit == null) {
        continue;
      }

      createdUnit = createdUnit.trim();
      if (createdUnit.isEmpty) {
        continue;
      }

      yield GeneratedOutput(gen, createdUnit);
    }
  }

  Future<bool> _hasAnyTopLevelAnnotations(
    AssetId input,
    Resolver resolver,
    BuildStep buildStep,
  ) async {
    if (!await buildStep.canRead(input)) return false;
    final parsed = await resolver.compilationUnitFor(input);
    final partIds = <AssetId>[];
    for (var directive in parsed.directives) {
      if (directive.metadata.isNotEmpty) return true;
      if (directive is PartDirective) {
        partIds.add(
          AssetId.resolve(Uri.parse(directive.uri.stringValue!), from: input),
        );
      }
    }
    for (var declaration in parsed.declarations) {
      if (declaration.metadata.isNotEmpty) return true;
    }
    for (var partId in partIds) {
      if (await _hasAnyTopLevelAnnotations(partId, resolver, buildStep)) {
        return true;
      }
    }
    return false;
  }
}

class TestBuilderException implements Exception {
  late final String message;
  TestBuilderException(final String message) {
    this.message = "[TestBuilderException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
