import 'package:app_drawer/models/category.dart';
import 'package:app_drawer/models/product.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer';
import 'dart:convert';
import 'package:app_drawer/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ApiProduct {
  final String baseUrl = "http://192.168.1.10:3000/api/v1/products";
  Client client = Client();
  LoginState loginState = LoginState();

  Future<String> getToken() async {
    String value= await loginState.storage.read(key: "token");
    return value;
  }
  var category;
  Future<List<Product>> getProducts() async {
    var response = await client.get("$baseUrl");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["products"];
      log('aaa');
      category = output["data"]["category"];
      log(category.toString());
      return List<Product>.from(data.map((item) => Product.fromJson(item)));
    } else {
      return null;
    }
  }

  Future<bool> createProduct(Product data) async {
    //log("abc");
    String token;
    //log(token);
    token = await getToken();
    //log("abc1");
    //log(token);

    final response = await client.post(
      "$baseUrl",
      headers: {"content-type": "application/json","Authorization":"Bearer $token"},
      body: productToJson(data),
    );
    //log(response.statusCode.toString());
    //log(response.body);
    //400
    // tai sao lai loi 400-> do chua dang nhap chua co token
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(Product data) async {
    log(data.toString());
    //log("abc");
    String token;
    //log(token);
    token = await getToken();
    //log("abc1");
    //log(token);
    final response = await client.patch(
      "$baseUrl/${data.id}",
      headers: {"content-type": "application/json","Authorization":"Bearer $token"},
      body: productToJson(data),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    //log("abc");
    String token;
    //log(token);
    token = await getToken();
    //log("abc1");
    //log(token);
    //log(id.toString());
    final response = await client.delete(
      "$baseUrl/$id",
      headers: {"content-type": "application/json","Authorization":"Bearer $token"},
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
