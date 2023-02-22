import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/models/category_list.dart';
import 'package:restaurant/models/order_in_card.dart';
import 'package:restaurant/services/database.dart';
import '../../services/firebase.dart';
import 'detail.dart';

class MenuPage extends StatefulWidget {
  List<Product> products_list;
  DatabaseService databaseService;
  String uid;
  MenuPage({super.key, required this.products_list, required this.uid, required this.databaseService});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Widget> productsWidget = [];
  @override
  void initState() {
    initializeProductsWidget();
  }
  void initializeProductsWidget() {
    for (Product p in widget.products_list) {
      print(p.image_url);
      productsWidget.add(
      Container(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap:() {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Description(product: p, databaseService:widget.databaseService,),
          ),
        );
        },
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(p.image_url,height: 160,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$${p.price.toStringAsFixed(2)}',),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right : 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        //widget.databaseService.addOrder(widget.uid, p);
                        await DataService().addAProduct(widget.uid, p);
                      }, 
                      child: const Text('Add')
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Page'),),
      body: GridView.count(
        crossAxisCount: 2,
        children: productsWidget,
      ),    
    );
  }
}