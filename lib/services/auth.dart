import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coffee/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserCoffee _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null ? new UserCoffee(uid: firebaseUser.uid) : null;
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print('Error sign in anon');
      print(e.toString());
      return null;
    }
  }
}
