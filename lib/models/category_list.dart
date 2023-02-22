import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryList {
  String name;
  String image_url;
  List<Product> product_list;

  CategoryList({required this.name, required this.image_url, required this.product_list});

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products_list'] as Iterable<dynamic>;
    var products = productsJson.map((p) => Product.fromJson(p)).toList();
    return CategoryList(name: json['name'] as String, image_url: json['image_url'], product_list: products);
  }
}

class Product {
  int id;
  String name;
  String image_url;
  double price;
  String description;

  Product({required this.id, required this.name, required this.image_url, required this.price, required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'] as double,
        image_url: json['image_url'] as String,
        description: json['description'] as String);
  }

  // factory Product.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return Product(
  //     id: 0,
  //     name: data['name'] as String,
  //     price: data['price'] as double,
  //     image_url: '',
  //     description: ''
  //   );
  // }
}