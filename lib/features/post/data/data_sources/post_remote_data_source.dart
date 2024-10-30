import 'package:injectable/injectable.dart';
import 'package:pinapp/core/services/http_service.dart';
import 'package:pinapp/features/post/data/models/post_model.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

abstract class PostRemoteDataSourceBase {
  final HttpServiceBase http;

  PostRemoteDataSourceBase({required this.http});

  Future<List<Post>> getAllPosts();

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
}
