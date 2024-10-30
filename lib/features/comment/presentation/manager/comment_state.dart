part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class OnLoading extends CommentState {}

class OnGetCommentById extends CommentState {
  final Comment comment;

  OnGetCommentById({required this.comment});
}

class OnGetCommentByIdFailure extends CommentState {
  final Failure failure;

  OnGetCommentByIdFailure({required this.failure});
}
