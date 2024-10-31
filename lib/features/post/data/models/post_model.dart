import 'package:pinapp/features/post/data/data_sources/post_local_data_source.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.title,
    required super.body,
    required super.userId,
    required super.id,
    required super.liked,
  });

  static Future<Post> fromJson(
      Map<String, dynamic> map,
      PostLocalDataSourceBase localDataSource,
      ) async {
    final isLiked = await localDataSource.isLiked(map['id']);
    return PostModel(
      title: map['title'],
      body: map['body'],
      userId: map['userId'],
      id: map['id'],
      liked: isLiked,
    );
  }
}
