class ApiConstants {
  static const String baseUrl = 'https://google-news13.p.rapidapi.com';

  static String newsByCategoryEndpoint(String category) {
    return '/$category';
  }

  static const String rapidApiHost = 'google-news13.p.rapidapi.com';
  static const String rapidApiKey =
      'e5fbb272f6mshe7d268dfd5ff472p183f7djsnf6b04afcf8bd';

  static String newsByCategoryUrl(String category) {
    return '$baseUrl${newsByCategoryEndpoint(category)}';
  }
}
