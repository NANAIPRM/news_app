import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final String? title;
  final String? snippet;
  final String? publisher;
  final String? timestamp;
  final String? newsUrl;
  final Images? images;
  final bool? hasSubnews;
  final List<Subnews>? subnews;

  NewsModel({
    this.title,
    this.snippet,
    this.publisher,
    this.timestamp,
    this.newsUrl,
    this.hasSubnews,
    this.images,
    this.subnews,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class Images {
  final String? thumbnail;
  final String? thumbnailProxied;

  Images({
    this.thumbnail,
    this.thumbnailProxied,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class Subnews {
  final String? title;
  final String? snippet;
  final String? publisher;
  final String? timestamp;
  final String? newsUrl;
  final Images? images;

  Subnews({
    this.title,
    this.snippet,
    this.publisher,
    this.timestamp,
    this.newsUrl,
    this.images,
  });

  factory Subnews.fromJson(Map<String, dynamic> json) =>
      _$SubnewsFromJson(json);
  Map<String, dynamic> toJson() => _$SubnewsToJson(this);
}
