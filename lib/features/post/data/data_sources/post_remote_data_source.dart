import 'package:injectable/injectable.dart';
import 'package:pinapp/core/services/http_service.dart';
import 'package:pinapp/features/post/data/data_sources/post_local_data_source.dart';
import 'package:pinapp/features/post/data/models/post_model.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

abstract class PostRemoteDataSourceBase {
  final HttpServiceBase http;
  final PostLocalDataSourceBase localDataSourceBase;

  PostRemoteDataSourceBase({
    required this.http,
    required this.localDataSourceBase,
  });

  Future<List<Post>> getAllPosts();
}

@Injectable(as: PostRemoteDataSourceBase)
class PostRemoteDataSource extends PostRemoteDataSourceBase {
  PostRemoteDataSource({
    required super.http,
    required super.localDataSourceBase,
  });

  @override
  Future<List<Post>> getAllPosts() async {
    const String url = 'https://jsonplaceholder.typicode.com/posts';

    final result = await http.get(url);

    List<Post> posts = await Future.wait(
      (result as List).map((line) async {
        return await PostModel.fromJson(line, localDataSourceBase);
      }),
    );

    return posts;
  }
}
