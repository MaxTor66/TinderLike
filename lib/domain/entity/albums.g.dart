// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'albums': instance.albums.map((e) => e.toJson()).toList(),
    };
