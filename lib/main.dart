import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_kobkiat/bloc/favorite_new/favorite_new_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_bloc.dart';
import 'package:test_kobkiat/bloc/news/news_event.dart';
import 'package:test_kobkiat/screen/home_screen.dart';
import 'package:test_kobkiat/services/database_helper.dart';
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
    return AdaptiveTheme(
      light: ThemeData.light().copyWith(
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      dark: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NewsBloc(newsRepository)..add(const LoadNews('latest')),
          ),
          BlocProvider(
            create: (context) => FavoriteNewsBloc(newsRepository),
          ),
        ],
        child: MaterialApp(
          theme: darkTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
