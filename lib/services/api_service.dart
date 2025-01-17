import 'package:dio/dio.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/utils/api_constants.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.headers['x-rapidapi-host'] = ApiConstants.rapidApiHost;
    _dio.options.headers['x-rapidapi-key'] = ApiConstants.rapidApiKey;
    _dio.options.queryParameters['lr'] = 'en-US';
  }

  Future<List<NewsModel>> fetchNewsByCategory(String category) async {
    try {
      final url = ApiConstants.newsByCategoryUrl(category);
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data['items'];
        return jsonResponse
            .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load news: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load news: ${e.message}');
    }
  }
}
