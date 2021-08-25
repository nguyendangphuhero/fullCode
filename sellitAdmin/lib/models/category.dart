import 'dart:convert';
import 'dart:developer';

class Category {
  String id;
  String category;
  Category({this.id , this.category});

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(id: map["_id"], category: map["category"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "category": category};
  }

  @override
  String toString() {
    return 'Category{id: $id, category: $category}';
  }

}
List<Category> categoryFromJson(String jsonData) {
  log('jsondata $jsonData');
  var jsonconvert = json.decode(jsonData);
  log(jsonconvert);
  final data = jsonconvert.data;
  log('ok $data');
  return List<Category>.from(data.map((item) => Category.fromJson(item)));
}
String categoryToJson(Category data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
