//import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:convert';
import 'dart:io';
//import 'dart:math';
import 'package:app_drawer/models/authmodel.dart';
import 'package:app_drawer/screens/login.dart';
import 'package:app_drawer/utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<bool> authUser(AuthModel input);
}

class AuthServices extends AuthRepository {
  LoginState loginState = LoginState();
  @override
  Future<bool> authUser(AuthModel input) async {
    bool result = false;
    String baseurl = login;
    try {
      //log(baseurl);
      var response = await http.post(baseurl,
          body: json.encode(input),
          //token cho vao header
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      if (response.statusCode == 200) {
        //data la jsonBody
        var jsonBody = response.body;
        var output = json.decode(jsonBody);
        if (output["status"] == "Success") {
          result = true;
          String token= output["data"]["token"].toString();
          addToken(token);
          addUser(output["email"]);
        }
      }
    } catch (e) {
      debugPrint(e);
    }
    return result;
  }
  Future<void> addUser(String email) async {
    await loginState.storage.write(key: "token2", value: email);

  }
  Future<void> addToken(String token) async {
    await loginState.storage.write(key: "token", value: token);
  }
}
