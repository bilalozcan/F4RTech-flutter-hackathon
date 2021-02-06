import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';
import 'package:education/ui/post_page/post_page_model.dart';
import 'package:flutter/cupertino.dart';

class PostPageServices extends ChangeNotifier{
  Future<List<dynamic>> getAllStudent()async{
    var studentList = [];
    try{
      var result = await FirebaseFirestore.instance.collection('Students').get();
      if(result != null){
        result.docs.forEach((element) {
          studentList.add(Student.fromSnapshot(element));
        });

      }

      return studentList;
    } catch(e){
      print(e);
      return null;
    }
  }
}