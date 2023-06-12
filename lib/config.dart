class Config {
  static const String baseUrl = String.fromEnvironment('config.baseurl',
      defaultValue: 'https://api.unsplash.com');

  static const String clientId = String.fromEnvironment('config.clientId',
      defaultValue: 'O2qIzmt3l9PFFn713Op2sdE2ghpoAR6glMatK24Sc0o');
}
