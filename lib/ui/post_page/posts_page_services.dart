import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:education/models/User.dart' as usr;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostPageServices extends ChangeNotifier {
  FirestoreDBService firestoreDBService = FirestoreDBService();

  Future<List<dynamic>> getAllStudent() async {
    var studentList = [];
    try {
      var result =
          await FirebaseFirestore.instance.collection('Students').get();
      if (result != null) {
        result.docs.forEach((element) {
          studentList.add(Student.fromSnapshot(element));
        });
      }

      return studentList;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<dynamic> initUser(String uid) async {
    var firestoreDBService = FirestoreDBService();
    var result = await firestoreDBService.getUser(uid);
    if (result.runtimeType == usr.User) {
      return result;
    } else {
      return null;
    }
  }
  Future likeorDislike(Student student, usr.User user) async{
    var result = firestoreDBService.addLikeorDislikeStudent(student, user);
    var result2 = firestoreDBService.addLikeorDislikeUser(student, user);
  }
}
