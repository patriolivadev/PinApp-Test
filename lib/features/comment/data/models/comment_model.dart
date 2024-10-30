import 'package:pinapp/features/comment/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.body,
    required super.id,
    required super.name,
    required super.email,
    required super.postId,
  });

  factory CommentModel.fromJson(Map map) {
    return CommentModel(
      body: map['body'],
      id: map['id'],
      name: map['name'],
      email: map['email'],
      postId: map['postId'],
    );
  }
}
