import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:pinapp/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

abstract class PostRepositoryBase {
  final PostRemoteDataSourceBase remote;

  PostRepositoryBase({
    required this.remote,
  });

  Future<Either<Failure, List<Post>>> getAllPosts();
}
