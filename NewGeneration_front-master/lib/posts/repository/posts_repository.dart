import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newgeneration_front/posts/domain/post.dart';

class PostsRepository {
  static const String url = 'http://10.0.2.2:5000/api/posts/';

  static Future<List<Post>> getPostsByUserId(String userId) async {
    var response =
    await http.get(Uri.parse(url + userId));
    var postsJson = await json.decode(response.body);
    var postsFromMap = Post.fromMap(postsJson);
    return postsFromMap;
  }

  static Future<List<Post>> getAllPosts() async {
    var response =
    await http.get(Uri.parse(url));
    var postsJson = await json.decode(response.body);
    var postsFromMap = Post.fromMap(postsJson);
    return postsFromMap;
  }

  static Future deletePost(String postId) async {
    await http.delete(Uri.parse(url + postId));
  }
}