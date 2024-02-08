import 'package:newgeneration_front/profile/domain/followers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class FollowerRepository {

  static Future<List<Followers>> getFollowersByFollower(String idUser) async {
      var response = await http.get(Uri.parse('http://10.0.2.2:5000/api/followers/' + idUser));
      var followersJson = await json.decode(response.body);
      var follower = Followers.getFromMap(followersJson);
      //devuelve lista
      return follower;

  }
}