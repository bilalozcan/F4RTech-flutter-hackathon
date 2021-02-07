import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/app/helper.dart';
import 'package:education/app/strings.dart';
import 'package:education/models/Comment.dart';
import 'package:education/models/Student.dart';
import 'package:education/services/authentication.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:education/ui/post_detail_page/post_detail_page_services.dart';
import 'package:education/ui/post_page/posts_page_services.dart';
import 'package:education/widget/UserWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailPage extends StatefulWidget {
  final Student _student;

  PostDetailPage(this._student);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PostDetailPageServices _postDetailPageServices =
      PostDetailPageServices();
  final PostPageServices _postPageServices = PostPageServices();
  final Authentication _authentication = Authentication();
  final FirestoreDBService _firestoreDBService = FirestoreDBService();
  TextEditingController content = TextEditingController();
  bool enableKeyboard = true;
  var userUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget._student.fullname}',
          style: GoogleFonts.libreBaskerville(color: ColorTable.textColor),
        ),
        backgroundColor: ColorTable.swatch2.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: FutureBuilder(
        future: _authentication.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userUid = snapshot.data;
            return Container(
              height: Constants.getHeight(context),
              width: Constants.getWidth(context),
              child: Stack(
                children: [

                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: [
                          StudentInfo(),
                          CommentInfo(),
                          SizedBox(
                            height: Constants.getHeight(context) / 14.22,
                          )
                        ],

                      ),
                    ),
                  ),
                  TextInfo(),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  CommentWidget(String rozet, String fullname, Comment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [CommentUserInfo(rozet, fullname, comment.content)],
          ),
        ),
        Text(
          StringConstants.getDate(comment.dateOfComment),
          style:
              GoogleFonts.barlow(fontSize: Constants.getHeight(context) / 79),
        ),
        Divider(),
      ],
    );
  }

  Row CommentUserInfo(String rozet, String username, String comment) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Constants.getWidth(context) / 9,
          width: Constants.getWidth(context) / 9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                )
              ]),
          child: Image.asset(
            rozet,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Container(
            child: Text(
              '@${username} ${comment}',
              style: GoogleFonts.lato(
                fontSize: Constants.getHeight(context) / 65,
                fontWeight: FontWeight.w400,
                color: ColorTable.textColor,
              ),
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }

  Widget StudentInfo() {
    return Container(
      width: Constants.getWidth(context),
      height: Constants.getHeight(context) / 2,
      child: Column(
        children: [
          FutureBuilder(
              future: _postPageServices.initUser(widget._student.publisher),
              builder: (BuildContext context, AsyncSnapshot sp) {
                if (sp.hasData) {
                  return UserWidget(
                      rozet: '${Helper.UserIconLevel(sp.data)[1]}',
                      username: sp.data.username,
                      seviye: '${Helper.UserIconLevel(sp.data)[0]}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          Expanded(
            child: widget._student.picturesOfStudent.isEmpty
                ? Image.asset(
                    'assets/student/st1.png',
                    fit: BoxFit.fill,
                  )
                : Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                          widget._student.picturesOfStudent[index],
                          fit: BoxFit.scaleDown,
                          frameBuilder: (BuildContext context, Widget child,
                                  int frame, bool wasSynchronouslyLoaded) =>
                              wasSynchronouslyLoaded
                                  ? child
                                  : AnimatedOpacity(
                                      child: child,
                                      opacity: frame == null ? 0 : 1,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeOut,
                                    ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          });
                    },
                    itemCount: widget._student.picturesOfStudent.length,
                    itemWidth: Constants.getWidth(context),
                    itemHeight: Constants.getHeight(context) / 4,
                    layout: SwiperLayout.STACK,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Constants.getWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget._student.explanation,
                  style: GoogleFonts.crimsonText(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget CommentInfo() {
    return Container(
      height: Constants.getHeight(context) / 3.55,
      child: StreamBuilder(
        stream:
            _postDetailPageServices.initComments(widget._student.reference.id),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              var comment = Comment.fromSnapshot(document);
              return ListTile(
                title: FutureBuilder(
                  future: _firestoreDBService.getUser(comment.publisher),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CommentWidget(
                          '${Helper.UserIconLevel(snapshot.data)[1]}', snapshot.data.fullname, comment);
                    } else {
                      return SizedBox(
                        width: Constants.getHeight(context) / 28.44,
                        height: Constants.getHeight(context) / 28.44,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              );
              //TEK BİR YORUM -----------------
            }).toList(),
          );
        },
      ),
    );
  }

  Widget TextInfo() {
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    enableKeyboard =true;
                  });
                },
                child: Container(
                  width: Constants.getWidth(context) / 1.37,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: content,
                      decoration: InputDecoration(border: InputBorder.none),
                      enabled: enableKeyboard,
                      autofocus: true,
                      onTap: (){
                        setState(() {
                          enableKeyboard = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (userUid != null && content.text != '') {
                        _postDetailPageServices.postComment(userUid,
                            widget._student, content.text);
                          content.text = '';
                          enableKeyboard =false;
                      }
                    });
                  },
                  child: Container(
                    child: Text(
                      'Paylaş',
                      style: GoogleFonts.barlow(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
