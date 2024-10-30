import 'dart:async';
import 'package:core_encode/core_encode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/post/domain/entities/comment.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/domain/use_cases/get_comment_by_id_use_case.dart';
import 'package:pinapp/features/post/domain/use_cases/get_post_use_case.dart';

part 'post_event.dart';

part 'post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUseCase getPostUseCase;
  final GetCommentByIdUseCase getCommentByIdUseCase;

  PostBloc({
    required this.getPostUseCase,
    required this.getCommentByIdUseCase,
  }) : super(PostInitial()) {
    on<ActionGetPosts>(_getAllPosts);
    on<ActionGetCommentById>(_getCommentById);
  }

  FutureOr<void> _getAllPosts(
    ActionGetPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(OnLoading());

    final result = await getPostUseCase(NoParams());

    result.fold(
      (l) => emit(OnGetPostsFailure(failure: l)),
      (r) => emit(OnGetPosts(posts: r)),
    );
  }

  FutureOr<void> _getCommentById(
    ActionGetCommentById event,
    Emitter<PostState> emit,
  ) async {
    emit(OnLoading());

    final result = await getCommentByIdUseCase(event.id);

    result.fold(
      (l) => emit(OnGetCommentByIdFailure(failure: l)),
      (r) => emit(OnGetCommentById(comment: r)),
    );
  }
}
