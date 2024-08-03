import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/bloc/news/news_state.dart';
import 'package:test_kobkiat/screen/favorite_news_sceen.dart';
import 'package:test_kobkiat/screen/full_news_screen.dart';
import 'package:test_kobkiat/themes/constants.dart';
import 'package:test_kobkiat/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'latest';

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
      context.read<NewsBloc>().add(LoadNews(_selectedCategory));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            "News",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: titleTextColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteNewsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          _buildNewsContent(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = [
      'latest',
      'entertainment',
      'world',
      'business',
      'health',
      'sport',
      'science',
      'technology'
    ];

    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((category) {
          return _CategoryItem(
            category: category,
            isSelected: _selectedCategory == category,
            onTap: () => _onCategoryTap(category),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewsContent() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 250,
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.news.isNotEmpty) {
            return SizedBox(
              height: 600,
              child: Swiper(
                itemCount: state.news.length,
                itemWidth: MediaQuery.of(context).size.width * 0.9,
                itemHeight: MediaQuery.of(context).size.height,
                layout: SwiperLayout.STACK,
                axisDirection: AxisDirection.right,
                itemBuilder: (context, index) {
                  final news = state.news[index];
                  Color cardColor = cardColors[index % cardColors.length];
                  return NewsCard(
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
                      onSaveFavoriteNews: () {});
                },
              ),
            );
          } else if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No news available'));
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.center,
        child: Text(
          category[0].toUpperCase() + category.substring(1),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: isSelected ? 18.0 : 14.0,
          ),
        ),
      ),
    );
  }
}
