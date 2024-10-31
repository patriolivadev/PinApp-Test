part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class OnLoadingComments extends CommentState {}

class OnGetCommentsById extends CommentState {
  final List<Comment> comments;

  OnGetCommentsById({required this.comments});
}

class OnGetCommentByIdFailure extends CommentState {
  final Failure failure;

  OnGetCommentByIdFailure({required this.failure});
}
