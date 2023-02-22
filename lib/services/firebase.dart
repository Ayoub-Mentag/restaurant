

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:restaurant/models/order_in_card.dart';

// import '../models/category_list.dart';

// class DataService {
//   // final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('category_list');
//   // final CollectionReference productCollection = FirebaseFirestore.instance.collection('product_list');
//   // final CollectionReference boughtItmes = FirebaseFirestore.instance.collection('bought_items');
//   String? uid;
//   DataService({this.uid});

// //Problems 
// //1- how to set the doc id manually from the code 
// //2- how to add to add to a doc a subcollection
// //3- how to add to that subcollection a documents and setting the id manually
 
//   Future<void> addToBoughtCollection(OrderInCard orderInCard) async{
//     return await boughtItmes.doc(orderInCard.userId).collection('product_list').doc(orderInCard.product.id.toString()).set({
//       'name' : orderInCard.product.name,
//       'price' : orderInCard.product.price,
//       'quantity' : orderInCard.quantity,
//     });
//   }

//   List<OrderInCard> _itemFromSnapshot(QuerySnapshot? snapshot) {
//     return snapshot!.docs.map((doc) {
//       return OrderInCard(
//         userId : '',
//         product : Product(id: 0, name: doc.get('name'), image_url: '', price: doc.get('price'), description: ''),
//         quantity : doc.get('quantity')
//       );
//     }) as List<OrderInCard>;
//   }

//   Stream<List<OrderInCard>> get ordersInCard {
//     CollectionReference product_list = boughtItmes.doc(uid).collection('product_list');
//     return product_list.snapshots()
//       .map(_itemFromSnapshot);
//   }

//   void retrieveData() {
//     boughtItmes.get().then((value) {
//       print(value);
//     });
//   }



//   // List<CategoryList> _categroyListFromSnapshot(QuerySnapshot? snapshot) {
//   //   return snapshot!.docs.map((doc) {
//   //     return CategoryList(
//   //       name : doc.get('name'),//if it does not exist return an empty string
//   //       image_url : doc.get('image_url'),
//   //       product_list : [],
//   //     );
//   //   }).toList();
//   // }

//   // List<Product> _productListFromSnapshot(QuerySnapshot? snapshot) {
//   //   return snapshot!.docs.map((doc) {
//   //     return Product(
//   //       name : doc.get('name'),//if it does not exist return an empty string
//   //       image_url : doc.get('image_url'),
//   //       price: doc.get('price'),
//   //       description: doc.get('description'),
//   //     );
//   //   }).toList();
//   // }

//   // Stream<List<CategoryList>> get categories {
//   //   return categoryCollection.snapshots()
//   //     .map(_categroyListFromSnapshot);
//   // }


//   // Stream<List<Product>> get productOfCategory {
//   //   print("Category Id ${category_id}");
//   //   return categoryCollection.doc(category_id).collection('product_list').snapshots()
//   //     .map(_productListFromSnapshot);
//   // }



//   // // bought collection
//   // Future<void> addToBoughtCollection(String uid,Product food) async {
//   //   await boughtCollection.add({
//   //     'uid' : uid,
//   //     'name' :  food.name,
//   //     'image' : food.image,
//   //     'price' : food.price,
//   //   });
//   // }

// //   Future<List<Map<String, dynamic>>> getBoughtElementsOfUser(String uid, List<Food>? food_list_map) async {
// //     QuerySnapshot snapshot = await boughtCollection.where('uid', isEqualTo: uid).get();
// //     List<String> items = List<String>.from(
// //       snapshot.docs.map((document) => document.get('name').toString())).toList();
// //     List<String> food_list = List<String>.from(
// //       food_list_map!.map((element) => element.name.toString())).toList();
// //     List<int> bought_elements = List.filled(food_list.length, 0); 
// //     for (int i = 0; i < items.length; i++) {
// //       int index = food_list.indexOf(items[i]);
// //       bought_elements[index] += 1;
// //     } 
// //     List<Map<String, dynamic>> bill = [];
// //     for (int i = 0; i < food_list.length; i++) {
// //       bill[i] = {
// //         'name' : food_list[i],
// //         'price' : food_list_map[i].price * bought_elements[i],
// //         'nItems' : bought_elements[i],
// //       };
// //     }
// //     print(bill);
// //       return bill;
// //   }
// // }
// }

// /*
// void main() {
//   List<Map<String, dynamic>> items = [
//   {
//     'name' : 'pizza',
//     'price':15,
//   },
//   {
//     'name' : 'steak',
//     'price':25,
//   },
//   {
//     'name' : 'steak',
//     'price':25,
//   },
//   {
//     'name' : 'pizza',
//     'price':15,
//   },
//   {
//     'name' : 'steak',
//     'price':25,
//   },
//   {
//     'name' : 'pizza',
//     'price':15,
//   },
//   {
//     'name' : 'steak',
//     'price':25,
//   },
//  ];
//   List<String> food_list = ['pizza', 'steak'];
//   List<int> bought_elements = List.filled(food_list.length, 0);

//   int price = 0;
//   int nItems = 0;
//   String name = '';
  
//   for (int i = 0; i < items.length; i++) {
//     int index = food_list.indexOf(items[i]['name']);
//     bought_elements[index] += 1;
//   }
  
//   print(bought_elements);
// }

// */


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/models/category_list.dart';

class DataService {
  

  Future<void> addAProduct(String uid, Product product) async{
    CollectionReference productListRef = FirebaseFirestore.instance.collection('bought_items').doc(uid).collection('product_list');
    DocumentSnapshot docSnap = await productListRef.doc(product.id.toString()).get();
    
    if (docSnap.exists) {
      productListRef.doc(product.id.toString()).set({
      'id' : product.id.toString(),
      'name': product.name,
      'price':product.price,
      'quantity': docSnap['quantity'] + 1,
    });
    }
    else 
    {
      productListRef.doc(product.id.toString()).set({
        'id' : product.id.toString(),
        'name': product.name,
        'price':product.price,
        'quantity': 1,
      });
    }

  }

  Future<List<Map<String, dynamic>>> getProductList(String uid) async {
    CollectionReference productListRef = FirebaseFirestore.instance.collection('bought_items').doc(uid).collection('product_list');
    QuerySnapshot productListSnapshot = await productListRef.get();

    List<Map<String, dynamic>> productList = productListSnapshot.docs.map((doc) => {'id': doc.id, 'name': doc.get('name'), 'price': doc.get('price'), 'quantity': doc.get('quantity')}).toList();

    return productList;
  }


  Future<void> deleteAProduct(String uid, String productId) async {
    CollectionReference productListRef = FirebaseFirestore.instance.collection('bought_items').doc(uid).collection('product_list');
    await productListRef.doc(productId).delete();
  }

}