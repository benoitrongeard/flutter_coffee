import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/models/coffee.dart';
import 'package:flutter_coffee/screens/home/coffee-list.dart';
import 'package:flutter_coffee/services/auth.dart';
import 'package:flutter_coffee/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffees,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee App'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                label: Text('Logout', style: TextStyle(color: Colors.black))),
          ],
        ),
        body: CoffeeList(),
      ),
    );
  }
}
