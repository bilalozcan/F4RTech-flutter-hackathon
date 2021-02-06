import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Comment.dart';
import 'package:education/services/firestoredbservice.dart';

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

  Future postComment(String publisher, String student, String content) async {
    var comment = Comment(publisher, student, content, DateTime.now());
    var result = await firestoreDBService.postComment(comment);
  }
}
