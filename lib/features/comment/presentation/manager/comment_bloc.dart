import 'dart:async';
import 'package:core_encode/core_encode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';
import 'package:pinapp/features/comment/domain/use_cases/get_comment_by_id_use_case.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentByIdUseCase getCommentByIdUseCase;

  CommentBloc({required this.getCommentByIdUseCase}) : super(CommentInitial()) {
    on<ActionGetCommentById>(_getCommentById);
  }

  FutureOr<void> _getCommentById(
    ActionGetCommentById event,
    Emitter<CommentState> emit,
  ) async {
    emit(OnLoading());

    final result = await getCommentByIdUseCase(event.id);

    result.fold(
      (l) => emit(OnGetCommentByIdFailure(failure: l)),
      (r) => emit(OnGetCommentById(comment: r)),
    );
  }
}
