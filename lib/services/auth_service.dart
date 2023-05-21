import 'dart:convert';

import 'package:flutter_ecommerce_ui_kit/config.dart';
import 'package:flutter_ecommerce_ui_kit/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String userId = "1";

class AuthService {
  final storage = FlutterSecureStorage();
  // Create storage
  Future<http.Response> login(UserCredential userCredential) async {
    var body = jsonEncode(
        {
          'email': userCredential.usernameOrEmail,
          'password': userCredential.password
        });
    final response = await http.post(
        Uri.parse(
            'https://c38xt4v3ka.execute-api.eu-north-1.amazonaws.com/users'),
        body: body,

      headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      userId = userCredential.usernameOrEmail;
      Map<String, dynamic> json = jsonDecode(response.body);
      String effect = json['policyDocument']['Statement'][0]['Effect'];
      print(effect);
      var perm = checkPermission(effect);
      if(!perm){
        return http.Response("Error", 400);
      }
      // setUser(response.body);
    } else {
      if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
//      throw Exception(response.body);
    }
    return response;
  }

  bool checkPermission(String effect){
    if(effect == "Allow")
      return true;
    return false;
  }

  Future<http.Response> register(User user) async {
    final response = await http
        .post(Uri.parse('https://9ka6j8i25d.execute-api.eu-north-1.amazonaws.com/users'),
        body: jsonEncode({
          'password': user.password,
          'email': user.email
        }));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      userId = user.email;
    } else {
      if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: 'Email already exist',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
//      throw Exception(response.body);
    }
    return response;
  }

  setUser(String value) async {
    await storage.write(key: 'user', value: value);
  }

  getUser() async {
    String? user = await storage.read(key: 'user');
    if (user != null) {
      return jsonDecode(user);
    }
    return {};
  }

  logout() async {
    await storage.delete(key: 'user');
  }
}
