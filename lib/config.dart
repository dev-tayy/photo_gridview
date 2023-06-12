class Config {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String clientId = String.fromEnvironment('ACCESS_TOKEN');

  Config() {
    if (baseUrl.isEmpty) {
      throw AssertionError('BASE_URL is not set');
    }
    if (clientId.isEmpty) {
      throw AssertionError('ACCESS_TOKEN is not set');
    }
  }
}
