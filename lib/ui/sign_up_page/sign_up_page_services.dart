import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:education/ui/home_page/home_page.dart';

class SignUpPageServices {
  final Authentication _authentication = Authentication();
  void signUp(
      BuildContext context,
      String email,
      String password,
      String passwordAgain,
      String fullName,
      String username,
      String phone) async {
    if (password != passwordAgain) {
      await Fluttertoast.showToast(msg: 'Şifreler Uyuşmuyor!');
    } else {
      var signup = await _authentication.signup(email, password);
      if (signup.runtimeType == FirebaseAuthException) {
        if (signup.code == 'email-already-in-use') {
          await Fluttertoast.showToast(
              msg: 'Bu email için zaten bir hesap var!',
              toastLength: Toast.LENGTH_LONG);
        } else if (signup.code == 'invalid-email') {
          await Fluttertoast.showToast(
              msg: 'E mail formatı yanlış!', toastLength: Toast.LENGTH_LONG);
        }
      } else if (signup != null) {
        final user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'id': user.uid,
          'fullname': fullName,
          'telephone': phone,
          'email': email,
          'username': username,
          'numberofstudentsadded': 0,
          'dateofregistration': DateTime.now(),
          'lasttransactiondate': DateTime.now(),
          'addedstudentlist': <String>[],
          'numberofdonationsmade': 0,
          'donationamount': 0,
          'level': 0,
          'point': 0,
          'listOfPost' : <String>[],
        });
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
