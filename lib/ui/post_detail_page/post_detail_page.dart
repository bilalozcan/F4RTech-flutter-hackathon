import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/models/Comment.dart';
import 'package:education/models/Student.dart';
import 'package:education/services/authentication.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:education/ui/post_detail_page/post_detail_page_services.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostDetailPage extends StatefulWidget {
  final Student _student;

  PostDetailPage(this._student);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostDetailPageServices _postDetailPageServices =
      PostDetailPageServices();
  final Authentication _authentication = Authentication();
  final FirestoreDBService _firestoreDBService = FirestoreDBService();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Detay'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _authentication.currentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(50, 168, 82, .5),
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      children: [
                        //FOTOLAR GRIDVİEW -----
                        widget._student.picturesOfStudent.isNotEmpty
                            ? GridView.count(
                                crossAxisCount: widget._student
                                                .picturesOfStudent.length %
                                            2 ==
                                        0
                                    ? 2
                                    : widget._student.picturesOfStudent.length,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                shrinkWrap: true,
                                children: List.generate(
                                    widget._student.picturesOfStudent.length,
                                    (index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(widget
                                          ._student.picturesOfStudent[index]),
                                    ),
                                  );
                                }),
                              )
                            : SizedBox(),
                        //FOTOLAR GRIDVİEW ------
                        Text(widget._student.fullname),
                        Text(widget._student.age.toString()),
                        Text(widget._student.classOfStudent.toString()),
                        Text(widget._student.explanation),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.favorite_border),
                            Icon(Icons.share),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    height: Constants.getHeight(context) / 12.93,
                    decoration: BoxDecoration(
                      color: ColorTable.swatch1.withOpacity(0.4),
                    ),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: content,
                        decoration: InputDecoration(
                            suffix: GestureDetector(
                              child: Icon(Icons.double_arrow_sharp),
                              onTap: () {
                                _postDetailPageServices.postComment(
                                    snapshot.data.uid,
                                    widget._student.reference.id,
                                    content.text);
                              },
                            ),
                            border: InputBorder.none,
                            hintText: 'Yorum',
                            contentPadding: EdgeInsets.only(left: 8)),
                        //autofocus: true,
                      ),
                    ),
                  ),
                  Container(
                      width: 250,
                      child: StreamBuilder(
                          stream: _postDetailPageServices
                              .initComments(widget._student.reference.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                Comment comment =
                                    Comment.fromSnapshot(document);
                                //TEK BİR YORUM -----------------
                                return ListTile(
                                  title: FutureBuilder(
                                    future: _firestoreDBService
                                        .getUser(comment.publisher),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        return Text(snapshot.data.fullname);
                                      }else{
                                        return SizedBox(width:25,height: 25,child: CircularProgressIndicator(),);
                                      }
                                    },
                                  ),
                                  subtitle: Text(document.data()['content']),
                                );
                                //TEK BİR YORUM -----------------
                              }).toList(),
                            );
                          }))
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
