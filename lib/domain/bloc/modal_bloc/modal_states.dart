import '../../entity/photos.dart';

abstract class ModalHomeState {}

class ModalHomeInitial extends ModalHomeState {}

class ModalHomeLoadedSuccessState extends ModalHomeState {
  Photos photos;

  ModalHomeLoadedSuccessState(this.photos);
}

class ModalLoadedErrorState extends ModalHomeState {
  final Object? exception;

  ModalLoadedErrorState({this.exception});
}
