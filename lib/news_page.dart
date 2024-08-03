import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/bloc/news/news_state.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _selectedCategory = 'latest';

  String formatTimestamp(String timestamp) {
    final int milliseconds = int.tryParse(timestamp) ?? 0;
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
    final localDateTime =
        dateTime.toLocal(); // Convert to local time zone if needed
    final formatter =
        DateFormat('yyyy-MM-dd HH:mm:ss'); // Customize the format as needed
    return formatter.format(localDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
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
                            // Dispatch an event to fetch news based on the selected category
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
          // News list
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.news.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final news = state.news[index];
                      return ListTile(
                        title: Text(news.title ?? ''),
                        subtitle: Text(formatTimestamp(news.timestamp ?? '')),
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
        ],
      ),
    );
  }
}
