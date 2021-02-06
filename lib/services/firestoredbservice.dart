import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Comment.dart';
import 'package:education/models/Student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:education/models/User.dart' as usr;

class FirestoreDBService {
  final _instance = FirebaseFirestore.instance;

  Future<dynamic> getUsers() async {
    var list = [];
    var collectionReference = await _instance.collection('Users');
    var querySnapshot =
        await collectionReference.orderBy('point', descending: true).get();

    print(querySnapshot.docs.toString());
    for (var i = 0; i < querySnapshot.docs.length; ++i) {
      var map = {};
      map['point'] = querySnapshot.docs[i].data()['point'];
      map['fullname'] = querySnapshot.docs[i].data()['fullname'];
      map['level'] = querySnapshot.docs[i].data()['level'];
      list.add(map);
    }
    return list;
  }

  Future<dynamic> getCurrentUser() async {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var _user;
    try {
      var result = await _instance.collection('Users').doc('${user.uid}').get();
      if (result != null) {
        _user = usr.User.fromSnapshot(result);
      }
      return _user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getUser(String uid) async {
    var _user;
    try {
      var result = await _instance.collection('Users').doc(uid).get();
      if (result != null) {
        _user = usr.User.fromSnapshot(result);
      }
      return _user;
    } catch (e) {
      print('A' + e);
      return e;
    }
  }

  Future<dynamic> getStudent(userID) async {
    var _instance = FirebaseFirestore.instance;
    var _student;
    try {
      var result =
          await _instance.collection('Students').doc('${userID}').get();
      if (result != null) {
        _student = Student.fromSnapshot(result);
        return _student;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> postComment(Comment comment) async {
    var shareName = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      var result = await FirebaseFirestore.instance
          .collection('Comments')
          .doc(shareName)
          .set(comment.toMap());
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
