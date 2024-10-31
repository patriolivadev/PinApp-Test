import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSourceBase {
  Future<void> addLike(int postId);
  Future<void> removeLike(int postId);
  Future<bool> isLiked(int postId);
}

@Injectable(as: PostLocalDataSourceBase)
class PostLocalDataSource extends PostLocalDataSourceBase {
  final SharedPreferences sharedPreferences;

  PostLocalDataSource({required this.sharedPreferences});

  static const String likedPostsKey = 'likedPosts';

  @override
  Future<void> addLike(int postId) async {
    final likedPosts = sharedPreferences.getStringList(likedPostsKey) ?? [];
    likedPosts.add(postId.toString());
    await sharedPreferences.setStringList(likedPostsKey, likedPosts.toSet().toList());
  }

  @override
  Future<void> removeLike(int postId) async {
    final likedPosts = sharedPreferences.getStringList(likedPostsKey) ?? [];
    likedPosts.remove(postId.toString());
    await sharedPreferences.setStringList(likedPostsKey, likedPosts);
  }

  @override
  Future<bool> isLiked(int postId) async {
    final likedPosts = sharedPreferences.getStringList(likedPostsKey) ?? [];
    return likedPosts.contains(postId.toString());
  }
}
