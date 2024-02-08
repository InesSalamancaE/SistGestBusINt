import 'package:newgeneration_front/users/domain/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserRepository {
// Only while there are no auth system and while we define the architecture
  static Future<List<User>> getUsers() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:5000/api/users/getall'));
    var usersJson = await json.decode(response.body);
    var usersFromMap = User.getFromMap(usersJson);
    return usersFromMap;
  }

  static Future<User> getUserById(String id) async {
    var response = await http.get(Uri.parse('http://10.0.2.2:5000/api/users/' + id));
    var userJson = await json.decode(response.body);
    var user = User.getUserFromBody(userJson);
    return user;
  }
}
