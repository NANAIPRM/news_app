import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_kobkiat/models/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'news_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE news(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, snippet TEXT, publisher TEXT, timestamp TEXT, newsUrl TEXT, images TEXT, hasSubnews INTEGER, subnews TEXT, category TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertNews(NewsModel news, String category) async {
    final db = await database;

    // Convert Images and Subnews to JSON strings
    final imagesJson = news.images?.toJson();
    final subnewsJson = news.subnews?.map((s) => s.toJson()).toList();

    await db.insert(
      'news',
      {
        'title': news.title,
        'snippet': news.snippet,
        'publisher': news.publisher,
        'timestamp': news.timestamp,
        'newsUrl': news.newsUrl,
        'images': imagesJson != null ? json.encode(imagesJson) : null,
        'hasSubnews': news.hasSubnews ? 1 : 0,
        'subnews': subnewsJson != null ? json.encode(subnewsJson) : null,
        'category': category,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsModel>> getNewsByCategory(String category) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'news',
      where: "category = ?",
      whereArgs: [category],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      return NewsModel(
        title: map['title'],
        snippet: map['snippet'],
        publisher: map['publisher'],
        timestamp: map['timestamp'],
        newsUrl: map['newsUrl'],
        images: map['images'] != null
            ? Images.fromJson(json.decode(map['images']))
            : null,
        hasSubnews: map['hasSubnews'] == 1,
        subnews: map['subnews'] != null
            ? (json.decode(map['subnews']) as List)
                .map((s) => Subnews.fromJson(s))
                .toList()
            : null,
      );
    });
  }
}