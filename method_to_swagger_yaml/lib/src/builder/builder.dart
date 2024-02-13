// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';

import 'generated_output.dart';
import 'generator.dart';
import 'generator_for_annotation.dart';
import 'library.dart';
import 'utils.dart';

/// A [Builder] wrapping on one or more [Generator]s.
class _Builder extends Builder {
  /// Function that determines how the generated code is formatted.
  final String Function(String) formatOutput;

  /// The generators run for each targeted library.
  final List<Generator> _generators;

  /// The [buildExtensions] configuration for `.dart`
  final String _generatedExtension;

  /// Whether to emit a standalone (non-`part`) file in this builder.
  bool get _isYamlBuilder => this is YamlBuilder;

  final String _header;

  /// Whether to allow syntax errors in input libraries.
  final bool allowSyntaxErrors;

  @override
  final Map<String, List<String>> buildExtensions;

  /// Wrap [_generators] to form a [Builder]-compatible API.
  ///
  /// If available, the `build_extensions` option will be extracted from
  /// [options] to allow output files to be generated into a different directory
  _Builder(
    this._generators, {
    String Function(String code)? formatOutput,
    String generatedExtension = '.g.dart',
    List<String> additionalOutputExtensions = const [],
    String? header,
    this.allowSyntaxErrors = false,
    BuilderOptions? options,
  })  : _generatedExtension = generatedExtension,
        buildExtensions = validatedBuildExtensionsFrom(options != null ? Map.of(options.config) : null, {
          '.dart': [
            generatedExtension,
            ...additionalOutputExtensions,
          ],
        }),
        formatOutput = formatOutput ?? _formatter.format,
        _header = (header ?? defaultFileHeader).trim() {
    if (_generatedExtension.isEmpty || !_generatedExtension.startsWith('.')) {
      throw ArgumentError.value(
        _generatedExtension,
        'generatedExtension',
        'Extension must be in the format of .*',
      );
    }
    if (_isYamlBuilder && _generators.length > 1) {
      throw ArgumentError(
        'A standalone file can only be generated from a single Generator.',
      );
    }
    if (options != null && additionalOutputExtensions.isNotEmpty) {
      throw ArgumentError(
        'Either `options` or `additionalOutputExtensions` parameter '
        'can be given. Not both.',
      );
    }
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;

    if (!await resolver.isLibrary(buildStep.inputId)) return;

    if (_generators.every((g) => g is GeneratorForAnnotation) &&
        !(await _hasAnyTopLevelAnnotations(
          buildStep.inputId,
          resolver,
          buildStep,
        ))) {
      return;
    }

    final lib = await buildStep.resolver.libraryFor(buildStep.inputId, allowSyntaxErrors: allowSyntaxErrors);
    await _generateForLibrary(lib, buildStep);
  }

  Future<void> _generateForLibrary(
    LibraryElement library,
    BuildStep buildStep,
  ) async {
    final generatedOutputs = await _generate(library, _generators, buildStep).toList();

    // Don't output useless files.
    //
    // NOTE: It is important to do this check _before_ checking for valid
    // library/part definitions because users expect some files to be skipped
    // therefore they do not have "library".
    if (generatedOutputs.isEmpty) return;
    final outputId = buildStep.allowedOutputs.first;
    final contentBuffer = StringBuffer();

    if (_header.isNotEmpty) {
      contentBuffer.writeln(_header);
    }

    for (var item in generatedOutputs) {
      contentBuffer
        ..writeln()
        /*
        ..writeln(_headerLine)
        ..writeAll(
          LineSplitter.split(item.generatorDescription).map((line) => '// $line\n'),
        )
        ..writeln(_headerLine)
        ..writeln()
        // */
        ..writeln(item.output);
    }

    var genPartContent = contentBuffer.toString();

    try {
      // genPartContent = formatOutput(genPartContent);
    } catch (e, stack) {
      log.severe(
        '''
An error `${e.runtimeType}` occurred while formatting the generated source for
  `${library.identifier}`
which was output to
  `${outputId.path}`.
This may indicate an issue in the generator, the input source code, or in the
source formatter.''',
        e,
        stack,
      );
    }

    await buildStep.writeAsString(outputId, genPartContent);
  }

  @override
  String toString() => 'Generating $_generatedExtension: ${_generators.join(', ')}';
}

/// A [Builder] which generates standalone Dart library files.
///
/// A single [Generator] is responsible for generating the entirety of the
/// output since it must also output any relevant import directives at the
/// beginning of it's output.
class YamlBuilder extends _Builder {
  /// Wrap [generator] as a [Builder] that generates Dart library files.
  ///
  /// [generatedExtension] indicates what files will be created for each `.dart`
  /// input.
  /// Defaults to `.g.dart`, however this should usually be changed to
  /// avoid conflicts with outputs from a [SharedPartBuilder].
  /// If [generator] will create additional outputs through the [BuildStep] they
  /// should be indicated in [additionalOutputExtensions].
  ///
  /// [formatOutput] is called to format the generated code. Defaults to
  /// [DartFormatter.format].
  ///
  /// [header] is used to specify the content at the top of each generated file.
  /// If `null`, the content of [defaultFileHeader] is used.
  /// If [header] is an empty `String` no header is added.
  ///
  /// [allowSyntaxErrors] indicates whether to allow syntax errors in input
  /// libraries.
  YamlBuilder(
    Generator generator, {
    String Function(String code)? formatOutput,
    String generatedExtension = '.g.dart',
    List<String> additionalOutputExtensions = const [],
    String? header,
    bool allowSyntaxErrors = false,
    BuilderOptions? options,
  }) : super(
          [generator],
          formatOutput: formatOutput,
          generatedExtension: generatedExtension,
          additionalOutputExtensions: additionalOutputExtensions,
          header: header,
          allowSyntaxErrors: allowSyntaxErrors,
          options: options,
        );
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

final _formatter = DartFormatter(fixes: [StyleFix.singleCascadeStatements]);

const defaultFileHeader = '# GENERATED CODE - DO NOT MODIFY BY HAND';

final _headerLine = '// '.padRight(77, '*');

const partIdRegExpLiteral = r'[A-Za-z_\d-]+';

final _partIdRegExp = RegExp('^$partIdRegExpLiteral\$');

String languageOverrideForLibrary(LibraryElement library) {
  final override = library.languageVersion.override;
  return override == null ? '' : '// @dart=${override.major}.${override.minor}\n';
}
