import 'dart:convert';
import 'dart:developer';

class Product {
  String id;
  String name;
  int price;
  String imageUrl;
  String category;
  String details;
  Product({this.id , this.name, this.price, this.imageUrl, this.category, this.details});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(id: map["_id"], name: map["name"],price: map["price"],imageUrl: map["imageUrl"],category: map["category"],details: map["details"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name,"price": price,"imageUrl": imageUrl,"category": category,"details": details };
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, price: $price, imageUrl: $imageUrl, category: $category, details: $details}';
  }

}
List<Product> productFromJson(String jsonData) {
  //log('jsondata $jsonData');
  //var jsonconvert = json.decode(jsonData);
  //log(jsonconvert);
  //final data = jsonconvert.data;
  //log('ok $data');
  //return List<Product>.from(data.map((item) => Product.fromJson(item)));
}
String productToJson(Product data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
