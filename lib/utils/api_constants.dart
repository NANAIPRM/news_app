class ApiConstants {
  static const String baseUrl = 'https://google-news13.p.rapidapi.com';

  static String newsByCategoryEndpoint(String category) {
    return '/$category';
  }

  static const String rapidApiHost = 'google-news13.p.rapidapi.com';
  static const String rapidApiKey =
      '4ec5370c1fmsh9916149b132a649p1f5207jsnc87eb3cbb566';

  static String newsByCategoryUrl(String category) {
    return '$baseUrl${newsByCategoryEndpoint(category)}';
  }
}
