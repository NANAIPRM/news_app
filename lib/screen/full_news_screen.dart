import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_bloc.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_event.dart';
import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/screen/favorite_news_sceen.dart';
import 'package:test_kobkiat/screen/web_view_screen.dart';
import 'package:test_kobkiat/themes/constants.dart';
import 'package:test_kobkiat/widgets/news_card.dart';
import 'package:test_kobkiat/widgets/sub_news_card.dart';

class FullNewsScreen extends StatelessWidget {
  final NewsModel? news;
  final Subnews? subnews;
  final Color cardColor;

  const FullNewsScreen({
    super.key,
    required this.cardColor,
    this.news,
    this.subnews,
  });

  @override
  Widget build(BuildContext context) {
    final isSubnews = subnews != null;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: primaryTextColor,
        backgroundColor: cardColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_sharp),
            onPressed: () {
              context.read<FavoriteNewsBloc>().add(
                    SaveFavoriteNews(
                      isSubnews
                          ? subnews!.timestamp ?? ''
                          : news?.timestamp ?? '',
                    ),
                  );
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(isSubnews),
                const SizedBox(height: 10),
                _buildTimestamp(isSubnews),
                const SizedBox(height: 16),
                _buildImage(isSubnews),
                const SizedBox(height: 16),
                _buildSnippet(isSubnews),
                const SizedBox(height: 16),
                if (!isSubnews && news?.newsUrl != null) _buildNewsUrl(context),
                const SizedBox(height: 16),
                if (!isSubnews &&
                    news?.subnews != null &&
                    news!.subnews!.isNotEmpty)
                  _buildSubNewsSwiper(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(bool isSubnews) {
    return Text(
      isSubnews ? subnews!.title ?? '' : news?.title ?? '',
      style: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildTimestamp(bool isSubnews) {
    return Text(
      isSubnews
          ? formatTimestamp(subnews!.timestamp ?? '')
          : formatTimestamp(news?.timestamp ?? ''),
      style: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildImage(bool isSubnews) {
    final imageUrl =
        isSubnews ? subnews!.images?.thumbnail : news?.images?.thumbnail;
    return imageUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        : Container();
  }

  Widget _buildSnippet(bool isSubnews) {
    return Text(
      isSubnews ? subnews!.snippet ?? '' : news?.snippet ?? '',
      style: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildNewsUrl(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: news!.newsUrl!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
        ),
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: primaryTextColor,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'News Url',
              style: TextStyle(
                color: primaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubNewsSwiper(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemCount: news!.subnews!.length,
        itemHeight: 300,
        layout: SwiperLayout.DEFAULT,
        viewportFraction: 0.8,
        scale: 0.9,
        itemBuilder: (context, index) {
          final subnewsItem = news!.subnews![index];
          Color cardColor = cardColors[index % cardColors.length];
          return SubNewsCard(
            subNews: subnewsItem,
            cardColor: cardColor,
            onReadMore: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullNewsScreen(
                    subnews: subnewsItem,
                    cardColor: cardColor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
