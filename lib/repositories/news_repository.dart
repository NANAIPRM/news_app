import 'package:hive/hive.dart';
import 'package:test_kobkiat/models/article_model.dart';
import 'package:test_kobkiat/services/api_service.dart';

class NewsRepository {
  final ApiService _apiService;
  final Box<ArticleModel> _newsBox;

  NewsRepository(this._apiService, this._newsBox);

  Future<List<ArticleModel>> getNews() async {
    final newsList = await _apiService.fetchNewsByCategory('latest');

    for (var news in newsList) {
      await _newsBox.add(news);
    }

    return newsList;
  }

  List<ArticleModel> getNewsFromLocal() {
    return _newsBox.values.toList();
  }
}
