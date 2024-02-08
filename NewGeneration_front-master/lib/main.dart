import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:newgeneration_front/layout/widgets/buttons.dart';
import 'package:newgeneration_front/posts/widgets/create_post.dart';
import 'package:newgeneration_front/posts/widgets/posts_feed.dart';
import 'package:newgeneration_front/profile/widgets/profile.dart';
import 'package:newgeneration_front/profile/widgets/profile_selection.dart';
import 'package:newgeneration_front/profile/repository/profile_edit.dart';
import 'package:newgeneration_front/posts/widgets/delete_post.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NavigationMenu(),
      routes: {
        CreatePost.routeName: (ctx) => const CreatePost(),
        Profile.routeName: (ctx) => const Profile(),
        ProfileSelection.routeName: (ctx) => const ProfileSelection(),
        PostsFeed.routeName: (ctx) => const PostsFeed(),
        ProfileEdit.routeName: (ctx) => const ProfileEdit(),
        DeletePost.routeName: (ctx) => const DeletePost()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 290, 8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              alignment: Alignment.topLeft, //It doesn't fucking work
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(145, 600, 145, 10),
            width: 55,
            height: 55,
            child: MaterialButton(
              shape: CircleBorder(
                  side: BorderSide(
                      width: 1,
                      color: Colors.black38,
                      style: BorderStyle.solid,
                  ),
              ),

              color: Colors.black,
              onPressed: (){
                print('clicked');
              },
            ),
          ),
       ),
      ),
    );
  }
}


