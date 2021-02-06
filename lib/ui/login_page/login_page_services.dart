import 'package:education/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageServices {
  Authentication _authentication = Authentication();

  void signIn(BuildContext context, String email, String password) async {
    var login = await _authentication.login(email, password, context);
    if (login.runtimeType == FirebaseAuthException) {
      if (login.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'Bu email ile kayıtlı kullanıcı bulunamadı',
            toastLength: Toast.LENGTH_LONG);
        print('No user found for that email.');
      } else if (login.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'Şifre Yanlış', toastLength: Toast.LENGTH_LONG);
        print('Wrong password provided for that user.');
      } else if (login.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: 'Yanlış biçimde bir email adresi girdiniz',
            toastLength: Toast.LENGTH_LONG);
        print('The email address is badly formatted.');
      } else {
        print(login.code);
      }
    } else if (login != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scaffold(
                    body: Center(
                      child: Text('Giriş Yapıldı'),
                    ),
                  )));
    }
  }

  void signUp(BuildContext context, String email, String password,
      String fullName, String username, String phone) async {
    var signup = await _authentication.signup(email, password);
    if (signup.runtimeType == FirebaseAuthException) {
      if (signup.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'Bu email için zaten bir hesap var!',
            toastLength: Toast.LENGTH_LONG);
      } else if (signup.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: 'E mail formatı yanlış!', toastLength: Toast.LENGTH_LONG);
      }
    } else if (signup != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => null));
    }
  }
}
