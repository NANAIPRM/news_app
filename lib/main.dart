import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:test_kobkiat/models/article_model.dart';
import 'package:test_kobkiat/services/api_service.dart';
import 'package:test_kobkiat/repositories/news_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register the adapters
  Hive.registerAdapter(ImagesAdapter());
  Hive.registerAdapter(SubnewsAdapter());
  Hive.registerAdapter(ArticleModelAdapter());

  final newsBox = await Hive.openBox<ArticleModel>('newsBox');

  // Create instances of your services
  final apiService = ApiService();
  final newsRepository = NewsRepository(apiService, newsBox);

  runApp(MyApp(newsRepository: newsRepository));
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository;

  MyApp({required this.newsRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen(newsRepository: newsRepository),
    );
  }
}

class NewsScreen extends StatefulWidget {
  final NewsRepository newsRepository;

  NewsScreen({required this.newsRepository});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<ArticleModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _loadNews();
  }

  Future<List<ArticleModel>> _loadNews() async {
    try {
      return await widget.newsRepository.getNews();
    } catch (e) {
      return widget.newsRepository.getNewsFromLocal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.newsUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}
