import 'package:flutter/material.dart';

import 'package:newgeneration_front/profile/domain/followers.dart';
import 'package:newgeneration_front/profile/repository/followers_repository.dart';

import '../domain/followers_arguments.dart';

class FollowButton extends StatefulWidget {
  var idUser;
  var idFollower;

  FollowButton(this.idUser, this.idFollower, {Key? key}) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {

  late bool areFriends;
  late bool userfsFollower;
  late bool followerfsUser;

  bool loading = true;

  //No se como usar esta mierda...
  void _inicializandoMiWidget() async {
    await _followerisFollowingUser(widget.idUser, widget.idFollower);
  }

  Future<bool> _followerisFollowingUser(var idUser, var idFollower) async {
    List<Followers> listFollowers = await FollowerRepository
        .getFollowersByFollower(idUser);
    if (listFollowers.contains(idFollower)) {
      followerfsUser = true;
    } else {
      followerfsUser = false;
    }
    return followerfsUser;
  }

  Future<bool> _userisFollowingFollower(var idUser, var idFollower) async {
    List<Followers> listFollowers = await FollowerRepository
        .getFollowersByFollower(idFollower);
    if (listFollowers.contains(idUser)) {
      userfsFollower = true;
    } else {
      userfsFollower = false;
    }
    return userfsFollower;
  }

  Future<bool> _areFriends(var idUser, var idFollower) async {
    if (await _followerisFollowingUser(idUser, idFollower) &&
        await _userisFollowingFollower(idFollower, idUser)) {
      areFriends = true;
    } else {
      areFriends = false;
    }
    return areFriends;
  }

  //Falta un método para actualizar el back si se pulsa el botón.

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute
          .of(context)!
          .settings
          .arguments as FollowersArguments;
      _followerisFollowingUser(args.idUser, args.idFollower);
      _userisFollowingFollower(args.idUser, args.idFollower);
      _areFriends(args.idUser, args.idFollower);
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? CircularProgressIndicator() : IconButton(
      icon: Icon(
          areFriends ? Icons.supervised_user_circle : userfsFollower ? Icons
              .check_circle : Icons.add),
      onPressed: () {
        if (areFriends | userfsFollower) {
          const Icon(Icons.add);
          //Llamar al método para actualizar back
        } else {
          if (followerfsUser) {
            const Icon(Icons.supervised_user_circle);
            //Llamar al método para actualizar back
          } else {
            const Icon(Icons.check_circle);
            //Llamar al método para actualizar back
          }
        }
      },

    );
  }
}

    /*//If the user does NOT follow the account;
    if (!userfsFollower){
      return
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            //verificamos si es seguidor o amigo y el botón cambia en función
            if (followerfsUser){
              setState(() {
                const Icon(Icons.supervised_user_circle);
                    //ACTUALIZAR INFO

                });
            } else {
              setState(() {
                const Icon(Icons.check_circle);
                //ACTUALIZAR INFO
              });
            }

          },
        );
    //If the user does follow the account
    } else {
      //Si son amigos
      if( areFriends){
        return
          IconButton(
              icon: const Icon(Icons.supervised_user_circle),
              onPressed: () {
                setState(() {
                  const Icon(Icons.add);
                  //ACTUALIZAR INFO
                });
              }

          );
      } else {
        return
          IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: () {
                setState(() {
                  const Icon(Icons.add);
                  //ACTUALIZAR INFO
                });
              }

          );
      }*/


