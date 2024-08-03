class ApiConstants {
  static const String baseUrl = 'https://google-news13.p.rapidapi.com';

  static String newsByCategoryEndpoint(String category) {
    return '/$category';
  }

  static const String rapidApiHost = 'google-news13.p.rapidapi.com';
  static const String rapidApiKey =
      '4a8368073bmshbc6dbf58e3bff2bp1a4b4ajsn4581e611c513';

  static String newsByCategoryUrl(String category) {
    return '$baseUrl${newsByCategoryEndpoint(category)}';
  }
}
