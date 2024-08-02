// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      publisher: json['publisher'] as String,
      timestamp: json['timestamp'] as String,
      newsUrl: json['newsUrl'] as String,
      hasSubnews: json['hasSubnews'] as bool,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      subnews: (json['subnews'] as List<dynamic>?)
          ?.map((e) => Subnews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'title': instance.title,
      'snippet': instance.snippet,
      'publisher': instance.publisher,
      'timestamp': instance.timestamp,
      'newsUrl': instance.newsUrl,
      'images': instance.images,
      'hasSubnews': instance.hasSubnews,
      'subnews': instance.subnews,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      thumbnail: json['thumbnail'] as String,
      thumbnailProxied: json['thumbnailProxied'] as String,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'thumbnailProxied': instance.thumbnailProxied,
    };

Subnews _$SubnewsFromJson(Map<String, dynamic> json) => Subnews(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      publisher: json['publisher'] as String,
      timestamp: json['timestamp'] as String,
      newsUrl: json['newsUrl'] as String,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubnewsToJson(Subnews instance) => <String, dynamic>{
      'title': instance.title,
      'snippet': instance.snippet,
      'publisher': instance.publisher,
      'timestamp': instance.timestamp,
      'newsUrl': instance.newsUrl,
      'images': instance.images,
    };
