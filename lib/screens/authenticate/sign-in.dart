import 'package:flutter/material.dart';
import 'package:flutter_coffee/services/auth.dart';
import 'package:flutter_coffee/shared/constants.dart';
import 'package:flutter_coffee/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String error = '';

  String userMail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to coffee app'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      print('toto');
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    label: Text('Register',
                        style: TextStyle(color: Colors.black))),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) {
                        setState(() => {userMail = value});
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) => value.length < 6
                          ? 'Enter an password 6+ chars long'
                          : null,
                      onChanged: (value) {
                        setState(() => {userPassword = value});
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400], onPrimary: Colors.white),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signIn(userMail, userPassword);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          } else {
                            print("form isn't valid");
                          }
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(height: 12.0),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
            ),
          );
  }
}
