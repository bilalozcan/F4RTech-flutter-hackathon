import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  final String uid;

  Authentication({this.uid});

  Future login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
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
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      print(e);
      return e;
    }catch(e){
      print('Sign Up Function Error $e');
    }
  }

}
