import 'package:education/ui/post_page/posts_page_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';

import '../background.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
                    return Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '@username',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Seviye',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              Icon(Icons.share),
                              Row(
                                children: [Icon(Icons.star), Text('(15)')],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                                'https://lh3.googleusercontent.com/6yhnZ_AjXZms_nqtlmSLNyQKAXJlZdsFpz_sg17jrnz0uwL7rMYmPQcO9MAqySxShCqFqNAqP6UvWjme2lLpebtdl0iMG_jYFymR=w1296-v1'),
                          ),
                          Container(
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
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('YOK'),
              );
            }
          },
=======
    return Stack(
      children: [
        backgroundContainer(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(elevation: 0, title: Text('Forum'), backgroundColor: Colors.transparent, centerTitle: true),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future: _firestoreDBService.getCurrentUser(),
                    builder: (context, auth) {
                      if (auth.hasData) {
                        return FutureBuilder(
                          future: _postPageServices.getAllStudent(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(snapshot.data[index])));
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorTable.textColor.withOpacity(0.05),
                                                    blurRadius: 8,
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  FutureBuilder(
                                                      future: _postPageServices.initUser(snapshot.data[index].publisher),
                                                      builder: (BuildContext context, AsyncSnapshot sp) {
                                                        if (sp.hasData) {
                                                          return UserWidget(
                                                              rozet: '${Helper.UserIconLevel(sp.data)[1]}',
                                                              username: sp.data.username,
                                                              seviye: '${Helper.UserIconLevel(sp.data)[0]}');
                                                        } else {
                                                          return CircularProgressIndicator();
                                                        }
                                                      }),
                                                  Container(
                                                    height: Constants.getHeight(context) / 4,
                                                    width: Constants.getWidth(context),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          child: Image.asset(
                                                            'assets/student/${int.parse(snapshot.data[index].uid) % 17 + 1}.png',
                                                            fit: BoxFit.contain,
                                                            height: Constants.getHeight(context) / 5,
                                                            width: Constants.getWidth(context) / 2.5,
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            StudentInfo('Öğrenci Adı-Soyadı', snapshot.data[index].fullname),
                                                            StudentInfo('Öğrenci Yaşı', snapshot.data[index].age.toString()),
                                                            StudentInfo('Sınıfı', snapshot.data[index].classOfStudent.toString()),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: Container(
                                                        height: Constants.getHeight(context) / 14.22,
                                                        width: Constants.getWidth(context),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                _postPageServices.likeorDislike(snapshot.data[index], auth.data);
                                                                setState(() {
                                                                  snapshot.data[index].likeCount;
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  snapshot.data[index].listOfLikes.contains(auth.data.uid)
                                                                      ? Icon(Icons.star)
                                                                      : Icon(Icons.star_border),
                                                                  Text(
                                                                    '${snapshot.data[index].likeCount} yıldız',
                                                                    style: GoogleFonts.crimsonText(fontSize: 9),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(context,
                                                                    MaterialPageRoute(builder: (context) => PostDetailPage(snapshot.data[index])));
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.messenger_outline),
                                                                  Text(
                                                                    '${snapshot.data[index].listOfComments.length} yorum',
                                                                    style: GoogleFonts.crimsonText(fontSize: 9),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => DonatePage(
                                                                              auth.data,
                                                                              snapshot.data[index],
                                                                            )));
                                                                setState(() {
                                                                  snapshot.data[index].donationCount;
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.money_sharp),
                                                                  Text(
                                                                    '${snapshot.data[index].donationCount} Bağış',
                                                                    style: GoogleFonts.crimsonText(fontSize: 9),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: Constants.getWidth(context) / 20.55,
                                            top: Constants.getHeight(context) / 71.1,
                                            child: Container(
                                                width: Constants.getWidth(context) / 3.1,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      snapshot.data[index].approvalStatus ? Icons.verified : Icons.adjust_outlined,
                                                      color: snapshot.data[index].approvalStatus ? Colors.green : Colors.yellow.shade700,
                                                      size: 35,
                                                    ),
                                                    Text(
                                                      '${snapshot.data[index].approvalStatus ? 'Onaylandı' : 'Onay Bekliyor'}',
                                                      style: GoogleFonts.lemonada(fontSize: Constants.getHeight(context) / 71.1),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: LoadingBouncingGrid.square(
                                  size: 30,
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: LoadingBouncingGrid.square(
                            size: 30,
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget StudentInfo(String s, String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s,
              style: GoogleFonts.poppins(fontSize: Constants.getHeight(context) / 59.25, fontWeight: FontWeight.w700),
            ),
            Container(
                alignment: Alignment.center,
                height: Constants.getHeight(context) / 23.7,
                width: Constants.getWidth(context) / 2.74,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white.withOpacity(0.7),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
                child: Text(
                  data,
                  style: GoogleFonts.poppins(fontSize: Constants.getHeight(context) / 59.25),
                )),
          ],
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}
