part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class ActionGetCommentById extends CommentEvent {
  final int id;

  ActionGetCommentById({required this.id});
}
