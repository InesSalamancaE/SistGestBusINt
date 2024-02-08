import 'package:flutter/material.dart';
import 'package:newgeneration_front/posts/repository/posts_repository.dart';

import '../domain/post_arguments.dart';

class DeletePost extends StatefulWidget {
  static const String routeName = 'deletePost';

  const DeletePost({Key? key}) : super(key: key);

  @override
  State<DeletePost> createState() => _DeletePostState();
}

class _DeletePostState extends State<DeletePost> {
  String? _postId;

  _setPostId(postId) {
    setState(() {
      _postId = postId;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute
          .of(context)!
          .settings
          .arguments as PostArguments;
      _setPostId(args.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text('Do you really want to delete this post?'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Yes"),
                onPressed: () async {
                  await PostsRepository.deletePost(_postId ?? '');
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
