part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class OnLoading extends PostState {}

class OnGetPosts extends PostState {
  final List<Post> posts;

  OnGetPosts({required this.posts});
}

class OnGetPostsFailure extends PostState {
  final Failure failure;

  OnGetPostsFailure({required this.failure});
}
