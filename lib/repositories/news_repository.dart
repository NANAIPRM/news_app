import 'package:test_kobkiat/helpers/news_db.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final DatabaseHelper _dbHelper;

  NewsRepository(this._apiService, this._dbHelper);

  Future<List<NewsModel>> getNews(String category) async {
    // Fetch news from the API
    final newsList = await _apiService.fetchNewsByCategory(category);

    // Save news data to local database
    await _saveNewsToLocal(newsList, category);

    return newsList;
  }

  Future<void> _saveNewsToLocal(
      List<NewsModel> newsList, String category) async {
    for (var news in newsList) {
      await _dbHelper.insertNews(news, category);
    }
  }

  Future<List<NewsModel>> getNewsFromLocal(String category) async {
    // Retrieve news data from local database
    final newsList = await _dbHelper.getNewsByCategory(category);

    return newsList.isNotEmpty ? newsList : [];
  }
}
