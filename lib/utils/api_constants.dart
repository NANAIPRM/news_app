class ApiConstants {
  static const String baseUrl = 'https://google-news13.p.rapidapi.com';

  static String newsByCategoryEndpoint(String category) {
    return '/$category';
  }

  static const String rapidApiHost = 'google-news13.p.rapidapi.com';
  static const String rapidApiKey =
      '9226cafbe3msh01d9e13ee771d08p1e5451jsn8eeaa3706993';

  static String newsByCategoryUrl(String category) {
    return '$baseUrl${newsByCategoryEndpoint(category)}?lr=en-US';
  }
}
