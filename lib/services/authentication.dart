import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:education/models/User.dart' as usr;

class Authentication {
  final String uid;

  Authentication({this.uid});

  Future login(String email, String password, BuildContext context) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    } catch (e) {
      print('Login Function Error: $e');
    }
  }

  Future signup(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    } catch (e) {
      print('Sign Up Function Error $e');
    }
  }

  Future<usr.User> currentUser() async {
    try {
      var _user = await FirebaseAuth.instance.currentUser;
      return userFromFirebase(_user);
    } catch (e) {
      print(e);
      return e;
    }
  }

  usr.User userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return usr.User(
        id: user.uid,
        email: user.email,
      );
    }
  }

  // ignore: always_declare_return_types
  signOut() async {
    var _user = await FirebaseAuth.instance;
    if (currentUser != null) {
      await _user.signOut();
    }
  }
}
