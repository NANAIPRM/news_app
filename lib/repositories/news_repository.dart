import 'package:test_kobkiat/services/database_helper.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final DatabaseHelper _dbHelper;

  NewsRepository(this._apiService, this._dbHelper);

  Future<List<NewsModel>> getNewsTodayFromLocal(String category) async {
    try {
      final fetchedNewsList = await _apiService.fetchNewsByCategory(category);

      final existingNewsList = await _dbHelper.getNewsByCategoryToday(category);

      final existingNewsTimestamps =
          existingNewsList.map((news) => news.timestamp).toSet();

      final newNewsList = fetchedNewsList
          .where((news) => !existingNewsTimestamps.contains(news.timestamp))
          .toList();

      if (newNewsList.isNotEmpty) {
        await _saveNewsToLocal(newNewsList, category);
      }

      return await _dbHelper.getNewsByCategoryToday(category);
    } catch (e) {
      return await _dbHelper.getNewsByCategoryToday(category);
    }
  }

  Future<void> _saveNewsToLocal(
      List<NewsModel> newsList, String category) async {
    try {
      for (var news in newsList) {
        await _dbHelper.insertNews(news, category);
      }
    } catch (e) {
      throw Exception('Error saving news to local:  $e');
    }
  }

  Future<void> markAsFavorite(String timestamp) async {
    try {
      await _dbHelper.setFavorite(timestamp);
    } catch (e) {
      throw Exception('Error marking news as favorite: $e');
    }
  }

  Future<List<NewsModel>> getFavoriteNews() async {
    try {
      final favoriteNews = await _dbHelper.getFavoriteNews();
      return favoriteNews;
    } catch (e) {
      throw Exception('Error to get favorite news');
    }
  }
}
