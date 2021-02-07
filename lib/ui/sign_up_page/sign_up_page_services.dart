import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/services/authentication.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:education/ui/navigation_bar/navigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:education/models/User.dart' as usr;

class SignUpPageServices {
  final Authentication _authentication = Authentication();
  final firestoreDBService = FirestoreDBService();

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
        var db = usr.User.Info(
            fullName,
            phone,
            email,
            username,
            user.uid,
            0,
            DateTime.now(),
            DateTime.now(),
            <String>[],
            <String>[],
            0,
            0,
            0,
            0,
            []);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .set(db.toMap());
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }

  String nameValidator(String name) {
    if (name.length < 2) {
      return 'Lütfen geçerli bir isim giriniz';
    }
    if (name.contains(RegExp('[0-9]'))) {
      return 'Lutfen gecerli bir isim giriniz';
    }
    return null;
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

  String repeatPasswordValidator(String repeatPassword, String password) {
    if (repeatPassword != password) {
      return 'Şifreler birbirleriyle eşleşmiyor';
    } else {
      return null;
    }
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

  String phoneValidator(phone) {
    var regExp = RegExp('(05|5)[0-9][0-9][0-9]([0-9]){6,6}');
    if (phone.length == 0) {
      return 'Lütfen Telefon Numarası Giriniz';
    } else if (!regExp.hasMatch(phone)) {
      return 'Geçersiz Telefon Numarası';
    }
    return null;
  }
}
