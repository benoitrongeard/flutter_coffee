import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_coffee/models/coffee.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Coffee> _coffeeListFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(
          name: doc.data()['name'] ?? '',
          sugars: doc.data()['sugars'] ?? '0',
          strength: doc.data()['strength'] ?? 0);
    }).toList();
  }

  Stream<List<Coffee>> get coffees {
    return coffeeCollection
        .snapshots()
        .map((event) => _coffeeListFromFirebase(event));
  }
}
