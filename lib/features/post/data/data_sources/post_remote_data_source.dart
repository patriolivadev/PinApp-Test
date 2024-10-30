import 'package:injectable/injectable.dart';
import 'package:pinapp/core/services/http_service.dart';
import 'package:pinapp/features/post/data/models/comment_model.dart';
import 'package:pinapp/features/post/data/models/post_model.dart';
import 'package:pinapp/features/post/domain/entities/comment.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

abstract class PostRemoteDataSourceBase {
  final HttpServiceBase http;

  PostRemoteDataSourceBase({required this.http});

  Future<List<Post>> getAllPosts();

  Future<Comment> getCommentById(int id);

}

@Injectable(as: PostRemoteDataSourceBase)
class PostRemoteDataSource extends PostRemoteDataSourceBase {
  PostRemoteDataSource({required super.http});

  @override
  Future<List<Post>> getAllPosts() async {
    const String url = 'https://jsonplaceholder.typicode.com/posts';

    final result = await http.get(url);

    List<Post> posts = (result as List)
        .map((line) => PostModel.fromJson(line))
        .toList();

    return posts;
  }

  @override
  Future<Comment> getCommentById(int id) async {
    String url = 'https://jsonplaceholder.typicode.com/comments?postId=$id';

    final result = await http.get(url);

    Comment comment = CommentModel.fromJson(result);

    return comment;
  }
}
