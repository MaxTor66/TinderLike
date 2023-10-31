import 'package:tinderlike/domain/entity/address.dart';
import 'package:tinderlike/domain/entity/photo.dart';

import 'album.dart';
import 'company.dart';


import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable(explicitToJson: true)
class User{
int id;
String name;
String username;
String email;
Address address;
String phone;
String website;
Company company;

@JsonKey(ignore: true)
List<Album> albums=[];
@JsonKey(ignore: true)
List<Photo> photos=[];


User(this.id, this.name, this.username, this.email, this.address, this.phone,
    this.website, this.company);

factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
Map<String, dynamic> toJson() => _$UserToJson(this);



void setUserAlbums(List<Album> listOfAlbums){
  this.albums=listOfAlbums;
}


void setUserPhotos(List<Photo> listOfPhotos){
  this.photos=listOfPhotos;
}




}