import '../../env/env_config.dart';

mixin UriMixin {
  String getUri(
    String path, {
    String version = 'v1',
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
  }) {
    // Replace {param} in path with actual values
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll('{$key}', value);
      });
    }

    // Parse the base URL to extract scheme, host, and port
    final baseUri = Uri.parse(EnvConfig.baseUrl);
    
    final uri = Uri(
      scheme: baseUri.scheme,
      host: baseUri.host,
      port: baseUri.hasPort ? baseUri.port : null,
      path: '/api/$version/$path',
      queryParameters: queryParameters,
    );

    return uri.toString();
  }
}
