import 'package:flutter/material.dart';
import 'package:restaurant/services/auth.dart';

import '../../shared/loading.dart';
import '../../shared/text_input.dart';
import '../Authenticate/authenticate.dart';

class SignIn extends StatefulWidget {
  Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field 
  String email = '';
  String password = '';

  //loading 
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In to our restaurant app',
          style: TextStyle(
            color : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: const Text('Register', style: TextStyle(color: Colors.black,),),
          ),
        ],
        backgroundColor: Colors.amber,
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0,),
        child: Form(
          key : _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Email cannot be empty' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.length <= 4 ? 'Password length should be more than 4' : null,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate())
                      {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => loading = false);
                          print('An error occured :(');
                        }
                      }
                    },
                    icon: const Icon(Icons.circle), 
                    label: const Text('Sign In', style: TextStyle(fontSize: 20),)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}