import 'package:flutter/material.dart';
import 'package:flutter_coffee/models/user.dart';
import 'package:flutter_coffee/screens/authenticate/authenticate.dart';
import 'package:flutter_coffee/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCoffee>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
