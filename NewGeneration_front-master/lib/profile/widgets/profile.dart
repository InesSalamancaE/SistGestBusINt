import 'package:flutter/material.dart';
import 'package:newgeneration_front/posts/domain/post.dart';
import 'package:newgeneration_front/posts/widgets/post_widget.dart';
import 'package:newgeneration_front/profile/domain/profile_arguments.dart';
import 'package:newgeneration_front/posts/repository/posts_repository.dart';
import 'package:newgeneration_front/profile/repository/profile_edit.dart';
import 'package:newgeneration_front/users/repository/user_repository.dart';
import 'package:newgeneration_front/users/domain/user.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';

  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // nullable because we want to check if exists before displaying its
  // properties to avoid error
  User? _user;
  List<Post> _posts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   UserRepository.getUserById('7bd98db5-deb2-4afc-bca9-628a2c9ae49f').then((x) {
  //     setState(() {
  //       _user = x;
  //     });
  //   });
  // }

  Future _setUser(String userId) async {
    UserRepository.getUserById(userId).then((users) {
      setState(() {
        _user = users;
      });
    });
  }

  Future _getUserPosts(String userId) async {
    PostsRepository.getPostsByUserId(userId).then((posts){
      if (posts.isNotEmpty) {
        setState(() {
          _posts = posts;
        });
      }
    });
  }

  bool _userSettled() {
    return _user != null;
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;
      _setUser(args.userId).then((value) => null);
      _getUserPosts(args.userId).then((value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(icon: const Icon(Icons.edit), onPressed: () {
            Navigator.pushNamed(context, ProfileEdit.routeName,
                arguments: ProfileArguments(_user?.id ?? ""));
          },),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 224, 140, 34),
            ),
            child: Container(
              width: double.infinity,
              height: 350.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_userSettled())
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          _user!.avatarFileUrl,
                        ),
                        radius: 50.0,
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (_userSettled())
                      Text(
                        _user!.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                    if (_userSettled())
                      Text(
                        "@" + _user!.username,
                        style: TextStyle(),
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 80.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Card(
                              shape: CircleBorder(),
                              color: Colors.amberAccent,
                              child: Column(
                                children: <Widget>[
                                  if (_userSettled())
                                    Text(
                                      _user!.followers.toString(),
                                      style: TextStyle(
                                        // fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    "seguidores",
                                  )
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.deepOrange,
                              shape: CircleBorder(),
                              margin: EdgeInsets.only(bottom: 30),
                              child: Column(
                                children: <Widget>[
                                  if (_userSettled())
                                    Text(
                                      _user!.friends.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.white),
                                    ),
                                  Text(
                                    "amigos",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.amberAccent,
                              shape: CircleBorder(),
                              child: Column(
                                children: <Widget>[
                                  if (_userSettled())
                                    Text(
                                      _user!.followed.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    "seguidos",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (_userSettled()) Text(_user!.bio)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var post in _posts)
                    PostWidget(postId: post.postId, fileUrl: post.fileUrl)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
