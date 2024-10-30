import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';
import 'package:pinapp/features/comment/domain/repositories/comment_repository_base.dart';

@Injectable(as: CommentRepositoryBase)
class CommentRepository extends CommentRepositoryBase {
  CommentRepository({required super.remote});

  @override
  Future<Either<Failure, Comment>> getCommentById(int id) async {
    try {
      Comment comment = await remote.getCommentById(id);
      return Right(comment);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnhandledFailure(message: '$e'));
    }
  }
}
