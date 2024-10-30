abstract class Comment{
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;


  Comment({
    required this.name,
    required this.email,
    required this.body,
    required this.postId,
    required this.id
  });
}
