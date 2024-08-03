import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/bloc/news/news_state.dart';
import 'package:test_kobkiat/themes/constants.dart';
import 'package:test_kobkiat/widgets/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'latest';

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
      ),
      body: Column(
        children: [
          Container(
            height: 60.0,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                'latest',
                'entertainment',
                'world',
                'business',
                'health',
                'sport',
                'science',
                'technology'
              ]
                  .map((category) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;

                            context
                                .read<NewsBloc>()
                                .add(LoadNews(_selectedCategory));
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          alignment: Alignment.center,
                          child: Text(
                            category[0].toUpperCase() + category.substring(1),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  _selectedCategory == category ? 18.0 : 14.0,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.news.isNotEmpty) {
                return SizedBox(
                  height: 600,
                  child: Swiper(
                    itemCount: state.news.length,
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.height,
                    layout: SwiperLayout.TINDER,
                    itemBuilder: (context, index) {
                      final news = state.news[index];
                      Color cardColor = cardColors[index % cardColors.length];
                      return NewsCard(
                        news: news,
                        cardColor: cardColor,
                        onReadMore: () {
                          // Handle Read More action
                        },
                      );
                    },
                  ),
                );
              } else if (state.error.isNotEmpty) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(child: Text('No news available'));
            },
          )
        ],
      ),
    );
  }
}
