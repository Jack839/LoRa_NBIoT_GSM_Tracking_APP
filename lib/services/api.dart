import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:lora_gpstracking2/models/user.dart';
import 'user.dart';
var users = new List<User>();
class API {
  //Fetching Authentication from server
  static Future<List<User>> getUsers(String email,String password) async {
    final uri= 'https://scratchnest.com/scratchnest_attend/scratchnestAttend_auth.php';
    var client=http_auth.DigestAuthClient(email,password);
    final response = await client.get(uri);
    //var response=await API.getUsers(email,password);
    Iterable list = json.decode(response.body);
    users = list.map((model) => User.fromJson(model)).toList();
    return users;
  }
}