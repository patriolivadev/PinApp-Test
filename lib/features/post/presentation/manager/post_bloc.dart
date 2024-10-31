import 'dart:async';
import 'package:core_encode/core_encode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/post/data/data_sources/post_local_data_source.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/domain/use_cases/get_post_use_case.dart';

part 'post_event.dart';

part 'post_state.dart';

@lazySingleton
@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUseCase getPostUseCase;
  final PostLocalDataSourceBase localDataSourceBase =
      getIt<PostLocalDataSourceBase>();

  List<Post>? posts;

  PostBloc({
    required this.getPostUseCase,
  }) : super(PostInitial()) {
    on<ActionGetPosts>(_getAllPosts);
    on<ToggleLike>(_toggleLike);
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

  FutureOr<void> _toggleLike(ToggleLike event, Emitter<PostState> emit) async {
    if (posts != null && event.index < posts!.length) {
      posts![event.index].liked = !posts![event.index].liked;

      if (posts![event.index].liked) {
        localDataSourceBase.addLike(posts![event.index].id);
      } else {
        localDataSourceBase.removeLike(posts![event.index].id);
      }

      emit(OnGetPosts(posts: List<Post>.from(posts!)));
    }
  }
}
