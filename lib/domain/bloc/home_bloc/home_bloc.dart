import 'package:bloc/bloc.dart';
import 'package:tinderlike/domain/data_provider/data_provider_users.dart';
import 'package:tinderlike/domain/entity/album_decoder.dart';

import '../../entity/photo_decoder.dart';
import '../../entity/users_decoder.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc(this.dataUsersProvider) : super(
      HomeInitial()) {
    on<OnLoadHomePageEvent>((event, emit) async {
      try {
        var jsonUsersFromServer = await dataUsersProvider.getUsersHttp();
        JsonUsersDecoder usersDecoder = JsonUsersDecoder();
        final users=usersDecoder.decode(jsonUsersFromServer);
        dynamic jsonAlbumsFromServer;
        dynamic jsonPhotosFromServer;

        for(var i=0; i<users.users.length; i++)
          {
           jsonAlbumsFromServer=await dataUsersProvider.getAlbumsHttp(users.users[i].id);
           JsonAlbumDecoder albumDecoder = JsonAlbumDecoder();
           var albums = albumDecoder.decode(jsonAlbumsFromServer);
           users.users[i].setUserAlbums(albums);
           jsonPhotosFromServer=await dataUsersProvider.getPhotosHttp(users.users[i].albums.first.id);
           JsonPhotoDecoder photoDecoder = JsonPhotoDecoder();
           var photos=photoDecoder.decode(jsonPhotosFromServer);
           users.users[i].setUserPhotos(photos);

          }


        emit(HomeLoadedSuccessState(users));
      } catch (e) {
        emit(HomeLoadedErrorState(exception: e));
      }



    });

  }

  DataUsersProvider dataUsersProvider;
}
