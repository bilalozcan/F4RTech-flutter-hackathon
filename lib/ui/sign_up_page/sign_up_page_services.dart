import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/services/authentication.dart';
import 'package:education/ui/navigation_bar/navigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:education/models/User.dart' as usr;

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
        var db = usr.User.Info(fullName, phone, email, username, user.uid, 0,
            DateTime.now(), DateTime.now(), <String>[], <String>[], 0, 0, 0, 0, []);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .set(db.toMap());
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }
}
