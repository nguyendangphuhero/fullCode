import 'dart:convert';
import 'dart:developer';

class User {
  String id;
  String name;
  String email;
  User({this.id , this.name, this.email});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(id: map["_id"], name: map["name"], email:  map["email"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email":email};
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

}
List<User> categoryFromJson(String jsonData) {
  // //log('jsondata $jsonData');
  // var jsonconvert = json.decode(jsonData);
  // //log(jsonconvert);
  // final data = jsonconvert.data;
  // //log('ok $data');
  // return List<Category>.from(data.map((item) => Category.fromJson(item)));
}
String categoryToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
