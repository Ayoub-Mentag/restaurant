import 'package:flutter/material.dart';
import 'package:restaurant/screens/Authenticate/register.dart';
import 'package:restaurant/screens/authenticate/sign_in.dart';
import 'package:restaurant/services/auth.dart';

class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (showSignIn)
    {
      return SignIn(toggleView : toggleView);
    }
    else {
      return Register(toggleView : toggleView);
    }
  }
}