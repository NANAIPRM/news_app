import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/helpers/news_db.dart';
import 'package:test_kobkiat/news_page.dart';
import 'package:test_kobkiat/repositories/news_repository.dart';
import 'package:test_kobkiat/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  final apiService = ApiService();
  final newsRepository = NewsRepository(apiService, databaseHelper);

  runApp(MyApp(newsRepository));
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository;

  const MyApp(this.newsRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsRepository),
      child: const MaterialApp(
        home: NewsPage(),
      ),
    );
  }
}
