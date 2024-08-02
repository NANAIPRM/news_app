import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:test_kobkiat/models/news_model.dart';
import 'package:test_kobkiat/services/api_service.dart';
import 'package:test_kobkiat/repositories/news_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir =
      await getApplicationDocumentsDirectory(); // Use the function here
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(NewsModelAdapter());

  final newsBox = await Hive.openBox<List<NewsModel>>('newsBox');

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
  late Future<List<NewsModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = widget.newsRepository.getNews('latest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: FutureBuilder<List<NewsModel>>(
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
