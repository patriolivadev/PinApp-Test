import 'package:core_encode/core_encode.dart';
import 'package:dartz/dartz.dart';
import 'package:pinapp/features/comment/data/data_sources/comment_remote_data_source.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';

abstract class CommentRepositoryBase {
  final CommentRemoteDataSourceBase remote;
  CommentRepositoryBase({required this.remote});

Future<Either<Failure, Comment>> getCommentById(int id);
}