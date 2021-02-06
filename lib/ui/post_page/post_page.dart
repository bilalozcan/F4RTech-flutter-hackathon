import 'package:education/app/constants.dart';
import 'package:education/ui/post_detail_page/post_detail_page.dart';
import 'package:education/ui/post_page/posts_page_services.dart';
import 'package:education/widget/UserWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:education/models/User.dart' as usr;
import 'package:google_fonts/google_fonts.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostPageServices _postPageServices = PostPageServices();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: FutureBuilder(
          future: _postPageServices.getAllStudent(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PostDetailPage(snapshot.data[index])));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                    future: _postPageServices.initUser(
                                        snapshot.data[index].publisher),
                                    builder: (BuildContext context,
                                        AsyncSnapshot sp) {
                                      if (sp.hasData) {
                                        return UserWidget(
                                            rozet: 'assets/1st.png',
                                            username: sp.data.username,
                                            seviye: sp.data.level);
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                Container(
                                  child: Icon(
                                    Icons.verified_outlined,
                                    size: 50,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: Constants.getHeight(context) / 4,
                              width: Constants.getWidth(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.network(
                                      'https://lh3.googleusercontent.com/6yhnZ_AjXZms_nqtlmSLNyQKAXJlZdsFpz_sg17jrnz0uwL7rMYmPQcO9MAqySxShCqFqNAqP6UvWjme2lLpebtdl0iMG_jYFymR=w1296-v1',
                                      fit: BoxFit.fill,
                                      height: Constants.getHeight(context) / 5,
                                      width: Constants.getWidth(context) / 2.5,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      StudentInfo('Öğrenci Adı-Soyadı',
                                          snapshot.data[index].fullname),
                                      StudentInfo('Öğrenci Yaşı',
                                          snapshot.data[index].age.toString()),
                                      StudentInfo(
                                          'Sınıfı',
                                          snapshot.data[index].classOfStudent
                                              .toString()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Açıklama",
                                  style: GoogleFonts.sriracha(fontSize: 12),
                                ),
                                Container(
                                  height: 100,
                                  width: Constants.getWidth(context),
                                  color: Colors.black,
                                ),
                              ],
                            )
                            /*Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(snapshot.data[index].fullname),
                                    Text(snapshot.data[index].age.toString()),
                                    Text(snapshot.data[index].classOfStudent
                                        .toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(snapshot.data[index].explanation),
                                    Icon(
                                      snapshot.data[index].approvalStatus
                                          ? Icons.verified
                                          : Icons.verified_outlined,
                                      color: snapshot.data[index].approvalStatus
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )*/
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  StudentInfo(String s, String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s,
              style: GoogleFonts.sriracha(fontSize: 12),
            ),
            Container(
                alignment: Alignment.centerLeft,
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 8)
                    ]),
                child: Text(
                  data,
                  style: GoogleFonts.robotoSlab(),
                )),
          ],
        ),
      ),
    );
  }
}
