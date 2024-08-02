import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/bloc/news/news_state.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.news.isNotEmpty) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final news = state.news[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.snippet),
                );
              },
            );
          } else if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No news available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<NewsBloc>(context).add(const LoadNews('world'));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
