
/* 
// ------------------------------------------------------------
// convert_target_method
// ------------------------------------------------------------
void main() async {
  initializeBuildLogTracking();

  tearDown(() {
    clearBuildLog();
  });

  final path = p.join('test', 'convert_target_method', 'test_data');

  // -------------- argument ----------------
  // /*
  // named argument
  final namedArgument = await initializeLibraryReaderForDirectory(
    p.join(path, 'argument'),
    'named_argument.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    namedArgument,
    SwaggerYamlGenerator(),
  );
  // */

  // positional argument
  final positionalArgument = await initializeLibraryReaderForDirectory(
    p.join(path, 'argument'),
    'positional_argument.dart',
  );

  testAnnotatedElements<ConvertTargetClass>(
    positionalArgument,
    SwaggerYamlGenerator(),
  );
}

// */