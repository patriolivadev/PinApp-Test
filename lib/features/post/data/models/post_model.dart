import 'package:pinapp/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.title,
    required super.body,
    required super.userId,
    required super.id,
  });

  factory PostModel.fromJson(Map map) {
    return PostModel(
      title: map['title'],
      body: map['body'],
      userId: map['userId'],
      id: map['id'],
    );
  }
}
