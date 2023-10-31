
import 'package:json_annotation/json_annotation.dart';
import 'album.dart';


part 'albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Albums{
  List<Album> albums;

  Albums(this.albums);

  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}