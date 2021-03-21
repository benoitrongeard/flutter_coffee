import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coffee/models/user.dart';
import 'package:flutter_coffee/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserCoffee _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null ? new UserCoffee(uid: firebaseUser.uid) : null;
  }

  Stream<UserCoffee> get user {
    return _auth
        .authStateChanges()
        .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser));
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

  // Signin with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print('Error during sign in the user');
      return null;
    }
  }

  // Register with email and password
  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      await DatabaseService(uid: firebaseUser.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print('Error during register the user');
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error during sign out');
      print(e.toString());
      return null;
    }
  }
}
