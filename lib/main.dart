import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/screens/Authenticate/authenticate.dart';
import 'package:restaurant/screens/wrapper.dart';
import 'package:restaurant/services/auth.dart';
import 'package:restaurant/services/database.dart';
import 'package:restaurant/services/firebase.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "YourAPIKey",
                             appId: "",
                             messagingSenderId: "", 
                             projectId: "YourProjectId")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
        primarySwatch: Colors.amber,),
        home: Wrapper(databaseService : databaseService),
      ),
    );
  }
}