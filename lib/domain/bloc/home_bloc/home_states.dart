
import '../../entity/users.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  Users users;

  HomeLoadedSuccessState(this.users);
}


class HomeLoadedErrorState extends HomeState {
  final Object? exception;
  HomeLoadedErrorState({this.exception});
}