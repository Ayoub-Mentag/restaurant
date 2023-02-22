import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant/models/category_list.dart';
import 'package:restaurant/models/order_in_card.dart';


class DatabaseService {
  List<CategoryList>? _categoryList;
  List<OrderInCard> ordersInCard = [];
  final String url = 'https://drive.google.com/uc?export=download&id=1cS8TLI1oZEJV6eLnWJGvwPgTwItatQF9';


  fetchMenu() async {
    var response = await http.get(Uri.parse(url));
    print('status code : ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var body = response.body;
        var decodeData = jsonDecode(body) as List<dynamic>;
        _categoryList = [];
        for (var json in decodeData) {
          _categoryList!.add(CategoryList.fromJson(json));
        }
      }
    }
    catch (e) {
      print('hello: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<List<CategoryList>?> getCategoryList() async {
    if (_categoryList == null) {
      await fetchMenu();
    }
    print('hello');
    return _categoryList;
  }


  addOrder(String uid, Product product) {

    bool found = false;
    for (OrderInCard orderInCard in ordersInCard) {
      if (orderInCard.product.id == product.id) {
        orderInCard.quantity += 1;
        found = true;
      }
    }
    if (found == false) {
      ordersInCard.add(OrderInCard(userId: uid, product: product, quantity: 1));
    }
  }
}