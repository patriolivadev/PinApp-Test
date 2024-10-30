abstract class Post{
  final int userId;
  final int id;
  final String title;
  final String body;
  bool liked;


  Post({
    required this.title,
    required this.body,
    required this.userId,
    required this.id,
    required this.liked
  });
}
