import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/bloc/news/news_state.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(const NewsState()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    try {
      emit(state.copyWith(loading: true));

      List<NewsModel> newsList =
          await _newsRepository.getNewsFromLocal(event.category);

      if (newsList.isEmpty) {
        newsList = await _newsRepository.getNews(event.category);
      }

      emit(state.copyWith(loading: false, news: newsList));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
