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
          "CREATE TABLE news(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, snippet TEXT, publisher TEXT, timestamp TEXT, newsUrl TEXT, images TEXT, hasSubnews INTEGER, subnews TEXT, category TEXT, favorite INTEGER)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          db.execute(
            "ALTER TABLE news ADD COLUMN favorite INTEGER",
          );
        }
      },
      version: 2,
    );
  }

  Future<void> insertNews(NewsModel news, String category) async {
    final db = await database;

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
        'hasSubnews': (news.hasSubnews ?? false) ? 1 : 0,
        'subnews': subnewsJson != null ? json.encode(subnewsJson) : null,
        'category': category,
        'favorite': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> setFavorite(String timestamp) async {
    final db = await database;

    final result = await db.query(
      'news',
      columns: ['favorite'],
      where: "timestamp = ?",
      whereArgs: [timestamp],
    );

    if (result.isNotEmpty && result.first['favorite'] == 1) {
      return;
    }

    await db.update(
      'news',
      {'favorite': 1},
      where: "timestamp = ?",
      whereArgs: [timestamp],
    );
  }

  Future<List<NewsModel>> getNewsByCategoryToday(String category) async {
    final db = await database;

    final now = DateTime.now().toUtc();
    final startOfDay = DateTime(now.year, now.month, now.day).toUtc();
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59).toUtc();

    final startTimestamp = startOfDay.millisecondsSinceEpoch;
    final endTimestamp = endOfDay.millisecondsSinceEpoch;

    final List<Map<String, dynamic>> maps = await db.query(
      'news',
      where: "category = ? AND timestamp BETWEEN ? AND ?",
      whereArgs: [category, startTimestamp, endTimestamp],
      orderBy: "timestamp DESC",
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

  Future<List<NewsModel>> getFavoriteNews() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'news',
      where: "favorite = ?",
      whereArgs: [1],
      orderBy: "timestamp DESC",
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
