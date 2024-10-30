import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';
import 'package:pinapp/features/comment/domain/repositories/comment_repository_base.dart';


@injectable
class GetCommentByIdUseCase extends UseCaseBase<Comment, int> {
  final CommentRepositoryBase commentRepositoryBase;

  GetCommentByIdUseCase({required this.commentRepositoryBase});

  @override
  Future<Either<Failure, Comment>> call(int params){
    return commentRepositoryBase.getCommentById(params);
  }
}