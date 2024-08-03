import 'package:card_swiper/card_swiper.dart';
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
      body: BlocBuilder<FavoriteNewsBloc, FavoriteNewsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.favoriteNews.isEmpty) {
            return const Center(child: Text('No favorite news found.'));
          }

          return Center(
            child: SizedBox(
              height: 600,
              child: Swiper(
                itemCount: state.favoriteNews.length,
                itemWidth: MediaQuery.of(context).size.width * 0.9,
                itemHeight: MediaQuery.of(context).size.height,
                layout: SwiperLayout.STACK,
                axisDirection: AxisDirection.right,
                itemBuilder: (context, index) {
                  final news = state.favoriteNews[index];
                  Color cardColor = cardColors[index % cardColors.length];
                  return NewsCard(
                      news: news,
                      cardColor: cardColor,
                      isFavorite: true,
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
                      onSaveFavoriteNews: () {});
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
