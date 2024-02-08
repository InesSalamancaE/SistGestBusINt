import 'package:flutter/material.dart';
import 'package:newgeneration_front/posts/domain/post.dart';
import 'dart:async';
import 'package:newgeneration_front/posts/repository/posts_repository.dart';


class PostsFeed extends StatefulWidget {
  static const String routeName = '/posts-feed';

  const PostsFeed({Key? key}) : super(key: key);

  @override
  _PostsFeed createState() => _PostsFeed();
}

class _PostsFeed extends State<PostsFeed> {
  final List<Post> _posts = [];

  Future<List<Post>> getPosts() async {
    var posts = await PostsRepository.getAllPosts();
    // No entiendo porque cojones me peta esto si está funcionando bien? me quiero morir
    return posts;
  }

  @override
  void initState() {
    super.initState();
    getPosts().then((value) {
      setState(() {
        _posts.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          // width: 360,
          // height: 200,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var post in _posts) Image.network(post.fileUrl)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
