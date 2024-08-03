import 'package:logger/web.dart';
import 'package:test_kobkiat/services/database_helper.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final DatabaseHelper _dbHelper;

  NewsRepository(this._apiService, this._dbHelper);

  final Logger _logger = Logger();

  Future<List<NewsModel>> getNewsToday(String category) async {
    try {
      final fetchedNewsList = await _apiService.fetchNewsByCategory(category);

      if (fetchedNewsList.isNotEmpty) {
        await _saveNewsToLocal(fetchedNewsList, category);

        final newsListToday = await _dbHelper.getNewsByCategoryToday(category);
        return newsListToday;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveNewsToLocal(
      List<NewsModel> newsList, String category) async {
    try {
      for (var news in newsList) {
        await _dbHelper.insertNews(news, category);
      }
    } catch (e) {
      _logger.e('Error saving news to local', error: {e});
    }
  }

  Future<List<NewsModel>> getNewsFromLocal(String category) async {
    final newsList = await _dbHelper.getNewsByCategoryToday(category);
    return newsList.isNotEmpty ? newsList : [];
  }
}
