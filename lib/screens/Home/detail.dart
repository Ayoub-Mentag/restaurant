import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/services/database.dart';

import '../../models/category_list.dart';

class Description extends StatefulWidget {
  Product product;
  DatabaseService databaseService;
  Description({Key? key, required this.product, required this.databaseService}) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to your home', style: TextStyle(color: Colors.black),),
        centerTitle: false,
      ),
      body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/background.jpeg'),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 10),
          child: SizedBox(
            height: 1000,
            child: Card(
              child: Column(
                children: <Widget>[
                  Image(image: NetworkImage(
                    widget.product.image_url,
                  )),
                  Text('name : ${widget.product.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('prince : ${widget.product.price.toString()}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('description : ${widget.product.description}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.databaseService.addOrder(user.uid, widget.product);
                      },
                      child: const Text('Add to card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}