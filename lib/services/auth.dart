/*
FirebaseUser has been changed to User
AuthResult has been changed to UserCredential
GoogleAuthProvider.getCredential() has been changed to GoogleAuthProvider.credential()
onAuthStateChanged which notifies about changes to the user's sign-in state was replaced with authStateChanges()
currentUser() which is a method to retrieve the currently logged in user, 
was replaced with the property currentUser and it no longer returns a Future<FirebaseUser>
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:micropig/models/user.dart';
import 'package:micropig/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create use obj based on User (Firebase)
  UserClass _userFromFirebaseUser(User user) {
    return user != null ? UserClass(uid: user.uid) : null;
  }

//auth change user stream
  Stream<UserClass> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

//sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
