import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:newgeneration_front/users/repository/user_repository.dart';
import 'package:newgeneration_front/users/domain/user.dart';
import '../domain/profile_arguments.dart';

class ProfileEdit extends StatefulWidget {
  static const String routeName = 'editProfile';

  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  late var imageController = TextEditingController();

  User? _user;

  Future _setUser(String userId) async {
    UserRepository.getUserById(userId).then((users) {
      setState(() {
        _user = users;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;
      _setUser(args.userId).then((value) => null);

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Card(child: InkWell( onTap: (){
            imageController = ImagePicker.platform.toString() as TextEditingController;
          },
            child: CircleAvatar(
            backgroundImage: NetworkImage(
              _user!.avatarFileUrl,

            ),

            radius: 50.0,
          ),
          ),
          ),
          Card(child: Column(children: <Widget>[
            TextField(decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
              controller: nameController,
              //http.post(url)
            ),
          ],
          ),
          ),
          Card(child: Column(children: <Widget>[
            TextField(decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Insert your bio',
            ),
              controller: bioController,
            ),
          ],
          ),
          ),
          TextButton(onPressed: () {

              _user?.name = nameController as String;
              _user?.bio = bioController as String;
              _user?.avatarFileUrl = imageController as String;
              initState();

          }, child: const Text('Save'))
        ],
        ),
      ),
    );
  }
}
