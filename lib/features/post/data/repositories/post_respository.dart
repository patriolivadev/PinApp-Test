import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/post/domain/entities/comment.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/domain/repositories/post_repository_base.dart';

@Injectable(as: PostRepositoryBase)
class PostRepository extends PostRepositoryBase {
  PostRepository({required super.remote});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    try {
      List<Post> posts = await remote.getAllPosts();
      return Right(posts);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnhandledFailure(message: '$e'));
    }
  }

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
