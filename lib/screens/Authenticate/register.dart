import 'package:flutter/material.dart';
import 'package:restaurant/screens/Authenticate/authenticate.dart';
import 'package:restaurant/services/auth.dart';
import 'package:restaurant/shared/text_input.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {
  Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //Text field
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register to our restaurant app',
          style: TextStyle(
            color : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: const Text('Sign In', style: TextStyle(color: Colors.black,),),
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
            child : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Email could not be empty' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length <= 4 ? 'Password at least should be 4 chars' : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
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
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => loading = false);
                          }
                        }
                      },
                      icon: const Icon(Icons.circle), 
                      label: const Text('Register', style: TextStyle(fontSize: 20),)
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