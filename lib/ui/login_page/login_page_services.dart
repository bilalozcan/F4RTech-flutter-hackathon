import 'package:education/services/authentication.dart';
import 'package:education/ui/navigation_bar/navigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageServices {
  final Authentication _authentication = Authentication();

  void signIn(BuildContext context, String email, String password) async {
    var login = await _authentication.login(email, password, context);
    if (login.runtimeType == FirebaseAuthException) {
      if (login.code == 'user-not-found') {
        await Fluttertoast.showToast(
            msg: 'Bu email ile kayıtlı kullanıcı bulunamadı',
            toastLength: Toast.LENGTH_LONG);
        print('No user found for that email.');
      } else if (login.code == 'wrong-password') {
        await Fluttertoast.showToast(
            msg: 'Şifre Yanlış', toastLength: Toast.LENGTH_LONG);
        print('Wrong password provided for that user.');
      } else if (login.code == 'invalid-email') {
        await Fluttertoast.showToast(
            msg: 'Yanlış biçimde bir email adresi girdiniz',
            toastLength: Toast.LENGTH_LONG);
        print('The email address is badly formatted.');
      } else {
        print(login.code);
      }
    } else if (login != null) {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  String passwordValidator(String password) {
    if (password.length < 6) {
      return 'Şifrenizin 6 karakterden daha büyük olması gerekmektedir.';
    }
    if (!password.contains(RegExp('[0-9]')) ||
        !password.contains(RegExp('[a-z]')) ||
        !password.contains(RegExp('[A-Z]'))) {
      return 'Şifreniz en az bir sayı,bir büyük harf ve bir küçük harf içermelidir';
    }
    return null;
  }

  String emailValidator(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return null;
    } else {
      return 'Hata';
    }
  }
}
