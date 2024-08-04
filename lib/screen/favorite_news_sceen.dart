import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_bloc.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_event.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_state.dart';
import 'package:test_kobkiat/screen/full_news_screen.dart';
import 'package:test_kobkiat/themes/constants.dart';
import 'package:test_kobkiat/widgets/news_card.dart';

class FavoriteNewsScreen extends StatelessWidget {
  const FavoriteNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteNewsBloc>().add(const LoadFavoriteNews());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<FavoriteNewsBloc, FavoriteNewsState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.favoriteNews.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.favoriteNews.length,
                  itemBuilder: (context, index) {
                    final news = state.favoriteNews[index];
                    Color cardColor = cardColors[index % cardColors.length];
                    double rotationAngle = (index % 2 == 0) ? -0.05 : 0.05;
                    return Transform.rotate(
                      angle: rotationAngle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: SizedBox(
                          height: 600,
                          child: NewsCard(
                            isFavorite: true,
                            news: news,
                            cardColor: cardColor,
                            onReadMore: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullNewsScreen(
                                    news: news,
                                    cardColor: cardColor,
                                  ),
                                ),
                              );
                            },
                            onSaveFavoriteNews: () {},
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state.error.isNotEmpty) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(child: Text('No news available'));
            },
          ),
        ),
      ),
    );
  }
}
