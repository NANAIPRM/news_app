import 'package:dio/dio.dart';
import 'package:test_kobkiat/utils/api_constants.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.headers['x-rapidapi-host'] = ApiConstants.rapidApiHost;
    _dio.options.headers['x-rapidapi-key'] = ApiConstants.rapidApiKey;
  }

  Future<Map<String, dynamic>> fetchNewsByCategory(String category) async {
    try {
      final url = ApiConstants.newsByCategoryUrl(category);
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load news: ${e.message}');
    }
  }
}
