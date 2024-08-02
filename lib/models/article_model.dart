import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class ArticleModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String snippet;

  @HiveField(2)
  final String publisher;

  @HiveField(3)
  final String timestamp;

  @HiveField(4)
  final String newsUrl;

  @HiveField(5)
  final Images? images;

  @HiveField(6)
  final bool hasSubnews;

  @HiveField(7)
  final List<Subnews>? subnews;

  ArticleModel({
    required this.title,
    required this.snippet,
    required this.publisher,
    required this.timestamp,
    required this.newsUrl,
    this.images, // Allow images to be null
    required this.hasSubnews,
    List<Subnews>? subnews,
  }) : subnews = hasSubnews ? subnews : null;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final hasSubnews = json['hasSubnews'] as bool;
    final subnewsList = hasSubnews
        ? (json['subnews'] as List<dynamic>?)
            ?.map((e) => Subnews.fromJson(e as Map<String, dynamic>))
            .toList()
        : null;

    return ArticleModel(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      publisher: json['publisher'] as String,
      timestamp: json['timestamp'] as String,
      newsUrl: json['newsUrl'] as String,
      images: json['images'] != null
          ? Images.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      hasSubnews: hasSubnews,
      subnews: subnewsList,
    );
  }

  Map<String, dynamic> toJson() {
    final json = _$ArticleModelToJson(this);
    if (!hasSubnews) {
      json['subnews'] = null;
    }
    return json;
  }
}

@HiveType(typeId: 1)
@JsonSerializable()
class Images {
  @HiveField(0)
  final String? thumbnail; // Make thumbnail nullable

  @HiveField(1)
  final String? thumbnailProxied;

  Images({
    this.thumbnail, // Allow thumbnail to be null
    this.thumbnailProxied,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Subnews {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String snippet;

  @HiveField(2)
  final String publisher;

  @HiveField(3)
  final String timestamp;

  @HiveField(4)
  final String newsUrl;

  @HiveField(5)
  final Images? images;

  Subnews({
    required this.title,
    required this.snippet,
    required this.publisher,
    required this.timestamp,
    required this.newsUrl,
    this.images,
  });

  factory Subnews.fromJson(Map<String, dynamic> json) =>
      _$SubnewsFromJson(json);
  Map<String, dynamic> toJson() => _$SubnewsToJson(this);
}
