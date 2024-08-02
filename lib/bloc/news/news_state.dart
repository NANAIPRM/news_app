import 'package:equatable/equatable.dart';
import 'package:test_kobkiat/models/news_model.dart';

class NewsState extends Equatable {
  final List<NewsModel> news;
  final bool loading;
  final String error;

  const NewsState(
      {this.news = const [], this.loading = false, this.error = ''});

  NewsState copyWith({List<NewsModel>? news, bool? loading, String? error}) {
    return NewsState(
        news: news ?? this.news,
        loading: loading ?? this.loading,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [news, loading, error];
}
