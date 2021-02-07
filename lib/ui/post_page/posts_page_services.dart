import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';
import 'package:flutter/cupertino.dart';

class PostPageServices extends ChangeNotifier {
  Future<List<dynamic>> getAllStudent() async {
    var studentList = [];
    try {
<<<<<<< Updated upstream
      var result =
          await FirebaseFirestore.instance.collection('Students').get();
=======
      var result = await FirebaseFirestore.instance.collection('Students').orderBy('uid', descending: true).get();
>>>>>>> Stashed changes
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
}
