import 'package:flutter/material.dart';
import 'package:newgeneration_front/profile/widgets/profile.dart';
import 'package:newgeneration_front/profile/domain/profile_arguments.dart';
import 'package:newgeneration_front/users/repository/user_repository.dart';
import 'package:newgeneration_front/users/domain/user.dart';

class ProfileSelection extends StatefulWidget {
  static const String routeName = 'profileSelection';

  const ProfileSelection({Key? key}) : super(key: key);

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  // Only while there are no auth system
  List<User> _users = [];
  String _dropdownValue = '';

  @override
  void initState() {
    super.initState();
    UserRepository.getUsers().then((x) {
      setState(() {
        _users = x;
        _dropdownValue = x.first.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownButton(
            value: _dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _dropdownValue = newValue!;
              });
            },
            items: _users.map((User value) {
              return DropdownMenuItem(
                value: value.id,
                child: Text(value.username),
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Profile.routeName,
                    arguments: ProfileArguments(_dropdownValue));
              },
              child: Text('Continue'))
        ]),
      ),
    );
  }
}
