import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_event.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_state.dart';
import 'package:test_kobkiat/repositories/news_repository.dart';

class FavoriteNewsBloc extends Bloc<FavoriteNewsEvent, FavoriteNewsState> {
  final NewsRepository _newsRepository;

  FavoriteNewsBloc(this._newsRepository) : super(const FavoriteNewsState()) {
    on<SaveFavoriteNews>(_onSaveFavoriteNews);
    on<LoadFavoriteNews>(_onLoadFavoriteNews);
  }

  Future<void> _onSaveFavoriteNews(
      SaveFavoriteNews event, Emitter<FavoriteNewsState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      await _newsRepository.markAsFavorite(event.timestamp);
      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadFavoriteNews(
      LoadFavoriteNews event, Emitter<FavoriteNewsState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      final favoriteNews = await _newsRepository.getFavoriteNews();
      emit(FavoriteNewsState(loading: false, favoriteNews: favoriteNews));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
