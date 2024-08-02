// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsModelAdapter extends TypeAdapter<NewsModel> {
  @override
  final int typeId = 0;

  @override
  NewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsModel(
      title: fields[0] as String,
      snippet: fields[1] as String,
      publisher: fields[2] as String,
      timestamp: fields[3] as String,
      newsUrl: fields[4] as String,
      images: fields[5] as Images?,
      hasSubnews: fields[6] as bool,
      subnews: (fields[7] as List?)?.cast<Subnews>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.snippet)
      ..writeByte(2)
      ..write(obj.publisher)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.newsUrl)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.hasSubnews)
      ..writeByte(7)
      ..write(obj.subnews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 1;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      thumbnail: fields[0] as String?,
      thumbnailProxied: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.thumbnail)
      ..writeByte(1)
      ..write(obj.thumbnailProxied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubnewsAdapter extends TypeAdapter<Subnews> {
  @override
  final int typeId = 2;

  @override
  Subnews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subnews(
      title: fields[0] as String,
      snippet: fields[1] as String,
      publisher: fields[2] as String,
      timestamp: fields[3] as String,
      newsUrl: fields[4] as String,
      images: fields[5] as Images?,
    );
  }

  @override
  void write(BinaryWriter writer, Subnews obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.snippet)
      ..writeByte(2)
      ..write(obj.publisher)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.newsUrl)
      ..writeByte(5)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubnewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      publisher: json['publisher'] as String,
      timestamp: json['timestamp'] as String,
      newsUrl: json['newsUrl'] as String,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      hasSubnews: json['hasSubnews'] as bool,
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
      'images': instance.images?.toJson(),
      'hasSubnews': instance.hasSubnews,
      'subnews': instance.subnews?.map((e) => e.toJson()).toList(),
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      thumbnail: json['thumbnail'] as String?,
      thumbnailProxied: json['thumbnailProxied'] as String?,
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
