part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class ActionGetPosts extends PostEvent {}

class ToggleLike extends PostEvent {
  final int index;

  ToggleLike({required this.index});
}

