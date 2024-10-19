library method_to_swagger_yaml_annotation;

class ConvertTargetClass {
  final String title;
  final String? description;
  final String version;
  final List<Tag> tags;

  const ConvertTargetClass({
    required this.title,
    required this.version,
    this.description,
    this.tags = const [],
  });
}

class ConvertTargetMethod {
  final HttpMethodDiv httpMethod;
  final String pathName;
  final List<String> tags;
  final String? summary;
  final String? operationId;

  /// Description for path
  final String? description;

  /// Description for HttpStatusCode 200
  final String responseDescription;

  const ConvertTargetMethod({
    required this.httpMethod,
    required this.pathName,
    this.description,
    this.responseDescription = "Successful operation",
    this.operationId,
    this.tags = const [],
    this.summary,
  });
}

class RequestParameter {
  final RequestParameterDiv requestParameterDiv;
  final String? description;
  final PathParameterStyleDiv? pathStyle;
  final QueryParameterStyleDiv? queryStyle;
  final bool? explode;
  final bool useToString;

  const RequestParameter({
    this.requestParameterDiv = RequestParameterDiv.query,
    this.description,
    this.pathStyle,
    this.queryStyle,
    this.explode,
    this.useToString = false,
  });
}

enum QueryParameterStyleDiv {
  from("from"),
  spaceDelimited("spaceDelimited"),
  pipeDelimited("pipeDelimited"),
  deepObject("deepObject"),
  ;

  final String toStringValue;

  const QueryParameterStyleDiv(this.toStringValue);
  factory QueryParameterStyleDiv.fromString({
    required String value,
  }) {
    final indexEnum = QueryParameterStyleDiv.values
        .firstWhere((e) => e.toStringValue == value);
    return indexEnum;
  }
}

enum PathParameterStyleDiv {
  simple("simple"),
  label("label"),
  matrix("matrix"),
  ;

  final String toStringValue;

  const PathParameterStyleDiv(this.toStringValue);
  factory PathParameterStyleDiv.from({
    required String value,
  }) {
    final indexEnum = PathParameterStyleDiv.values
        .firstWhere((e) => e.toStringValue == value);
    return indexEnum;
  }
}

enum RequestParameterDiv {
  query("query"),
  path("path"),
  /*
  TODO: implements
  header("header"),
  cookie("cookie"),
  // */
  ;

  final String toStringValue;

  const RequestParameterDiv(this.toStringValue);
  factory RequestParameterDiv.from({
    required String value,
  }) {
    final indexEnum =
        RequestParameterDiv.values.firstWhere((e) => e.toStringValue == value);
    return indexEnum;
  }
}

enum HttpMethodDiv {
  get("get"),
  post("post"),
  put("put"),
  patch("patch"),
  delete("delete"),
  ;

  final String toStringValue;

  const HttpMethodDiv(this.toStringValue);
  factory HttpMethodDiv.from({
    required String value,
  }) {
    final indexEnum =
        HttpMethodDiv.values.firstWhere((e) => e.toStringValue == value);
    return indexEnum;
  }
}

class ExternalDocs {
  final String? description;
  final String url;

  const ExternalDocs({
    required this.url,
    this.description,
  });
}

class ExternalDocsException implements Exception {
  late final String message;
  ExternalDocsException(final String message) {
    this.message = "[ExternalDocsException] $message";
  }
  @override
  String toString() {
    return message;
  }
}

class Tag {
  final String name;
  final String? description;
  final ExternalDocs? externalDocs;

  const Tag({
    required this.name,
    this.description,
    this.externalDocs,
  });
}

class TagException implements Exception {
  late final String message;
  TagException(final String message) {
    this.message = "[TagException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
