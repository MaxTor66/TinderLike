import 'package:bloc/bloc.dart';
import 'package:tinderlike/domain/data_provider/data_provider_users.dart';
import 'package:tinderlike/domain/entity/photos.dart';

import '../../entity/album.dart';
import '../../entity/photo.dart';
import '../../entity/photo_decoder.dart';
import 'modal_events.dart';
import 'modal_states.dart';

class ModalHomeBloc extends Bloc<ModalHomeEvents, ModalHomeState> {
  ModalHomeBloc(this.dataUsersProvider, this.listOfAlbums)
      : super(ModalHomeInitial()) {
    on<OnOpenModalHomePageEvent>((event, emit) async {
      try {
        Photos photos = Photos();
        List<Photo> fullListOfPhotos = [];
        for (int i = 0; i < listOfAlbums.length; i++) {
          var jsonPhotosFromServer =
              await dataUsersProvider.getPhotosHttp(listOfAlbums[i].id);

          JsonPhotoDecoder photoDecoder = JsonPhotoDecoder();
          var decodedPhotos = photoDecoder.decode(jsonPhotosFromServer);

          for (var element in decodedPhotos) {
            fullListOfPhotos.add(element);
          }
        }

        photos.setPhotos(fullListOfPhotos);

        emit(ModalHomeLoadedSuccessState(photos));
      } catch (e) {
        emit(ModalLoadedErrorState(exception: e));
      }
    });
  }

  DataUsersProvider dataUsersProvider;
  List<Album> listOfAlbums;
}
