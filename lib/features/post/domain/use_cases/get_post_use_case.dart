import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/domain/repositories/post_repository_base.dart';


@injectable
class GetPostUseCase extends UseCaseBase<List<Post>, NoParams> {
  final PostRepositoryBase postRepositoryBase;

  GetPostUseCase({required this.postRepositoryBase});

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params){
    return postRepositoryBase.getAllPosts();
  }
}