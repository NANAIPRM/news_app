import 'package:test_kobkiat/services/database_helper.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final DatabaseHelper _dbHelper;

  NewsRepository(this._apiService, this._dbHelper);

  Future<List<NewsModel>> getNews(String category) async {
    try {
      // Fetch news from the API
      final newsList = await _apiService.fetchNewsByCategory(category);

      // Check if the newsList is not empty
      if (newsList.isNotEmpty) {
        // Save news data to local database

        await _saveNewsToLocal(newsList, category);

        print('News for category $category saved successfully');
      } else {
        print('No news found for category $category');
      }

      return newsList;
    } catch (e) {
      print('Error fetching or saving news for category $category: $e');
      return [];
    }
  }

  Future<void> _saveNewsToLocal(
      List<NewsModel> newsList, String category) async {
    try {
      for (var news in newsList) {
        // Log the news object or any relevant details
        print('Saving news: ${news.toJson()}');

        // Ensure that the category is valid
        if (category == null || category.isEmpty) {
          throw ArgumentError('Category cannot be null or empty');
        }

        await _dbHelper.insertNews(news, category);
      }
    } catch (e, stackTrace) {
      // Log the error and stack trace for better debugging
      print('Error saving news to local storage: $e');
      print('Stack trace: $stackTrace');

      // Optionally, you can rethrow the error or handle it differently
      // rethrow;
    }
  }

  Future<List<NewsModel>> getNewsFromLocal(String category) async {
    // Retrieve news data from local database
    final newsList = await _dbHelper.getNewsByCategory(category);

    return newsList.isNotEmpty ? newsList : [];
  }
}
