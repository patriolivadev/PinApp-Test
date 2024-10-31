import 'package:injectable/injectable.dart';
import 'package:pinapp/core/services/http_service.dart';
import 'package:pinapp/features/comment/data/models/comment_model.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';

abstract class CommentRemoteDataSourceBase {
  final HttpServiceBase http;

  CommentRemoteDataSourceBase({required this.http});

  Future<List<Comment>> getCommentById(int id);

}

@Injectable(as: CommentRemoteDataSourceBase)
class CommentRemoteDataSource extends CommentRemoteDataSourceBase {
  CommentRemoteDataSource({required super.http});

  @override
  Future<List<Comment>> getCommentById(int id) async {
    String url = 'https://jsonplaceholder.typicode.com/comments?postId=$id';

    final result = await http.get(url);

    List<Comment> comments = (result as List).map((line) {
      return CommentModel.fromJson(line);
    }).toList();

    return comments;
  }
}
