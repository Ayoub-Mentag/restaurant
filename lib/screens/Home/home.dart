import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/services/auth.dart';
import 'package:restaurant/services/database.dart';
import '../../services/firebase.dart';
import 'orders_page.dart';
import 'category_page.dart';

class Home extends StatefulWidget {
  DatabaseService databaseService;
  Home({super.key, required this.databaseService});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Widget currentWidget = const Text('Default Widget !!');
    final user = Provider.of<User>(context);
    switch (currentIndex) {
      case 0 : 
        currentWidget = CategoryPage(databaseService: widget.databaseService,);
        break ;
      case 1 :
        // currentWidget = OrdersPage(uid: user.uid, databaseService: widget.databaseService);
        currentWidget = OrdersPage();
        break ;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to your home',),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => _auth.signOut(),
            child: const Text('Logout', style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout_outlined), label: "Orders"),
        ],
      ),
      body: currentWidget,
    );
  }
}