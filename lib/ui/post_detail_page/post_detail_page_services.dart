import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Comment.dart';
import 'package:education/models/Student.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:education/models/User.dart' as usr;

class PostDetailPageServices {
  FirestoreDBService firestoreDBService = FirestoreDBService();

  Stream<QuerySnapshot> initComments(String studentID){
    try {
      return FirebaseFirestore.instance.collection('Comments').where(
          'student', isEqualTo: studentID).snapshots();
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future postComment(usr.User publisher, Student student, String content) async {
    var comment = Comment(publisher.uid, student.uid, content, DateTime.now());
    var result = await firestoreDBService.postComment(comment, student);
  }
}
