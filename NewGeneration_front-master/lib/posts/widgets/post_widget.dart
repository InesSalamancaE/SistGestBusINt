import 'package:flutter/material.dart';

import 'delete_post.dart';
import '../domain/post_arguments.dart';

class PostWidget extends StatelessWidget {
  final String postId;
  final String fileUrl;

  const PostWidget({Key? key, required this.postId, required this.fileUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(fileUrl),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Navigator.pushNamed(context, DeletePost.routeName,
                arguments: PostArguments(postId));
          },
        )
      ],
    );
  }
}
