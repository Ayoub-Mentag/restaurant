import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/screens/Authenticate/authenticate.dart';
import 'package:restaurant/services/database.dart';
import 'package:restaurant/services/firebase.dart';

import 'Home/home.dart';

class Wrapper extends StatelessWidget {
  DatabaseService databaseService;
  Wrapper({super.key, required this.databaseService});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Authenticate();
    }
    else {
      return Home(databaseService: databaseService,);
    }
  }
}