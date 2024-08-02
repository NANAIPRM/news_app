import 'package:hive/hive.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final Box<List<NewsModel>> _newsBox;

  NewsRepository(this._apiService, this._newsBox);

  Future<List<NewsModel>> getNews(String category) async {
    final newsList = await _apiService.fetchNewsByCategory(category);

    await _newsBox.put(category, newsList);

    return newsList;
  }

  List<NewsModel> getNewsFromLocal(String category) {
    final newsList = _newsBox.get(category);
    return newsList ?? [];
  }
}
