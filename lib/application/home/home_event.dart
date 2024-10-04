part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetAllPosts extends HomeEvent {}

class GetMyPosts extends HomeEvent {}

class ChangeTabIndex extends HomeEvent {
  final int index;

  ChangeTabIndex({required this.index});
}
