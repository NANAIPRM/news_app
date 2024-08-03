import 'package:equatable/equatable.dart';

abstract class FavoriteNewsEvent extends Equatable {
  const FavoriteNewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoriteNews extends FavoriteNewsEvent {
  const LoadFavoriteNews();

  @override
  List<Object?> get props => [];
}

class SaveFavoriteNews extends FavoriteNewsEvent {
  final String timestamp;

  const SaveFavoriteNews(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}
