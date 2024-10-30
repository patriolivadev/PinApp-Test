import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/post/domain/entities/comment.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/domain/repositories/post_repository_base.dart';


@injectable
class GetCommentByIdUseCase extends UseCaseBase<Comment, int> {
  final PostRepositoryBase postRepositoryBase;

  GetCommentByIdUseCase({required this.postRepositoryBase});

  @override
  Future<Either<Failure, Comment>> call(int params){
    return postRepositoryBase.getCommentById(params);
  }
}