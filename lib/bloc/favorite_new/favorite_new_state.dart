import 'package:equatable/equatable.dart';
import 'package:test_kobkiat/models/news_model.dart';

class FavoriteNewsState extends Equatable {
  final List<NewsModel> favoriteNews;
  final bool loading;
  final String error;

  const FavoriteNewsState({
    this.favoriteNews = const [],
    this.loading = false,
    this.error = '',
  });

  FavoriteNewsState copyWith({
    List<NewsModel>? favoriteNews,
    bool? loading,
    String? error,
  }) {
    return FavoriteNewsState(
      favoriteNews: favoriteNews ?? this.favoriteNews,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [favoriteNews, loading, error];
}
