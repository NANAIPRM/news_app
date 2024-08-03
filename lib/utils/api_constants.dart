class ApiConstants {
  static const String baseUrl = 'https://google-news13.p.rapidapi.com';

  static String newsByCategoryEndpoint(String category) {
    return '/$category';
  }

  static const String rapidApiHost = 'google-news13.p.rapidapi.com';
  static const String rapidApiKey =
      '50ac30c137mshbe0f45663e9762ap191a97jsn15e42fbf4f60';

  static String newsByCategoryUrl(String category) {
    return '$baseUrl${newsByCategoryEndpoint(category)}';
  }
}
