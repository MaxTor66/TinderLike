import 'package:tinderlike/domain/entity/photo.dart';

import 'package:json_annotation/json_annotation.dart';

class Photos{

  List<Photo> photos=[];

  void setPhotos(List<Photo> listOfPhotos){
    this.photos=listOfPhotos;
  }


}