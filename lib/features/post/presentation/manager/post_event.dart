part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class ActionGetPosts extends PostEvent {}

class ActionGetCommentById extends PostEvent {
  final int id;

  ActionGetCommentById({required this.id});
}