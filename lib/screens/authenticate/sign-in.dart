import 'package:flutter/material.dart';
import 'package:flutter_coffee/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to coffee app'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('Sign in anon'),
          onPressed: () async {
            dynamic authResult = await _auth.signInAnon();
            if (authResult == null) {
              print('Error login');
            } else {
              print('signed in as ano');
              print(authResult);
            }
          },
        ),
      ),
    );
  }
}
