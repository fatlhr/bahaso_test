part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}
