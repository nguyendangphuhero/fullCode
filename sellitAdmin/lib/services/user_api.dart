import 'package:app_drawer/models/category.dart';
import 'package:app_drawer/models/user.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer';
import 'dart:convert';
import 'package:app_drawer/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ApiUser {
  final String baseUrl = "http://192.168.1.10:3000/api/v1/users";
  Client client = Client();
  LoginState loginState = LoginState();

  // Future<String> getToken() async {
  //   String value= await loginState.storage.read(key: "token");
  //   //value == null
  //   //Map<String, String> allValues = await loginState.storage.readAll();
  //   //log(value);
  //   //log('abc2');
  //   //log('a $allValues');
  //   //if(value == null) return "abc";
  //   return value;
  // }
  //lay category
  Future<User> getcountUsers() async {
    var response = await client.get("$baseUrl/get");
    //log(response.body.category.toString());
    //lay data duoc roi. data nam o dau
    //log(response.body);
    //log(categoryFromJson(response.body).toString());
    if (response.statusCode == 200) {
      //categoryFromJson(response.body);
      //log(response.body);
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["users"];
      //log(output["data"]["categories"].toString());
      //log(jsonBody.runtimeType.toString());
      //var jsonconvert = jsonDecode(jsonBody);
      //log(jsonconvert);
      //log('day');
      //log(List<Category>.from(data.map((item) => Category.fromJson(item))).toString());
      return data;

    } else {
      return null;
    }
  }
  Future<List<User>> getUsers() async {
    var response = await client.get("$baseUrl/get");
    //log(response.body.category.toString());
    //lay data duoc roi. data nam o dau
    //log(response.body);
    //log(categoryFromJson(response.body).toString());
    if (response.statusCode == 200) {
      //categoryFromJson(response.body);
      //log(response.body);
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["users"];
      //log(output["data"]["categories"].toString());
      //log(jsonBody.runtimeType.toString());
      //var jsonconvert = jsonDecode(jsonBody);
      //log(jsonconvert);
      //log('day');
      //log(List<Category>.from(data.map((item) => Category.fromJson(item))).toString());
      return List<User>.from(data.map((item) => User.fromJson(item)));

    } else {
      return null;
    }
  }

  // Future<bool> createProduct(Product data) async {
  //   //log("abc");
  //   String token;
  //   //log(token);
  //   token = await getToken();
  //   //log("abc1");
  //   //log(token);
  //
  //   final response = await client.post(
  //     "$baseUrl",
  //     headers: {"content-type": "application/json","Authorization":"Bearer $token"},
  //     body: productToJson(data),
  //   );
  //   //log(response.statusCode.toString());
  //   //log(response.body);
  //   //400
  //   // tai sao lai loi 400-> do chua dang nhap chua co token
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> updateProduct(Product data) async {
  //   log(data.toString());
  //   //log("abc");
  //   String token;
  //   //log(token);
  //   token = await getToken();
  //   //log("abc1");
  //   //log(token);
  //   final response = await client.patch(
  //     "$baseUrl/${data.id}",
  //     headers: {"content-type": "application/json","Authorization":"Bearer $token"},
  //     body: productToJson(data),
  //   );
  //   log(response.body.toString());
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> deleteProduct(String id) async {
  //   //log("abc");
  //   String token;
  //   //log(token);
  //   token = await getToken();
  //   //log("abc1");
  //   //log(token);
  //   //log(id.toString());
  //   final response = await client.delete(
  //     "$baseUrl/$id",
  //     headers: {"content-type": "application/json","Authorization":"Bearer $token"},
  //   );
  //   if (response.statusCode == 204) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
