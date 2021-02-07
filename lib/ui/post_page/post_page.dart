import 'dart:math';

import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/ui/donate_page/donate_page.dart';
import 'package:education/ui/post_detail_page/post_detail_page.dart';
import 'package:education/ui/post_page/post_page_model.dart';
import 'package:education/ui/post_page/posts_page_services.dart';
import 'package:education/widget/UserWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostPageServices _postPageServices = PostPageServices();
  final PostPageModel model = PostPageModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTable.swatch2.withOpacity(0.05),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Forum',
          style: GoogleFonts.libreBaskerville(color: ColorTable.textColor),
        ),
        backgroundColor: ColorTable.swatch2.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
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
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailPage(snapshot.data[index])));
                        });
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        ColorTable.textColor.withOpacity(0.05),
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
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
                                    height: Constants.getHeight(context) / 4,
                                    width: Constants.getWidth(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.asset(
                                            model.phtpTable[
                                                model.rng.nextInt(4)],
                                            fit: BoxFit.contain,
                                            height:
                                                Constants.getHeight(context) /
                                                    5,
                                            width: Constants.getWidth(context) /
                                                2.5,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            StudentInfo('Öğrenci Adı-Soyadı',
                                                snapshot.data[index].fullname),
                                            StudentInfo(
                                                'Öğrenci Yaşı',
                                                snapshot.data[index].age
                                                    .toString()),
                                            StudentInfo(
                                                'Sınıfı',
                                                snapshot
                                                    .data[index].classOfStudent
                                                    .toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                        height: Constants.getHeight(context) /
                                            14.22,
                                        width: Constants.getWidth(context),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.star_border),
                                                Text(
                                                  '100 yıldız',
                                                  style:
                                                      GoogleFonts.crimsonText(
                                                          fontSize: 9),
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PostDetailPage(
                                                                snapshot.data[
                                                                    index])));
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(Icons.messenger_outline),
                                                  Text(
                                                    '100 yorum',
                                                    style:
                                                        GoogleFonts.crimsonText(
                                                            fontSize: 9),
                                                  )
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DonatePage()));
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(Icons.money_sharp),
                                                  Text(
                                                    '10 Bağış',
                                                    style:
                                                        GoogleFonts.crimsonText(
                                                            fontSize: 9),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      snapshot.data[index].approvalStatus
                                          ? Icons.verified
                                          : Icons.adjust_outlined,
                                      color: snapshot.data[index].approvalStatus
                                          ? Colors.green
                                          : Colors.yellow.shade700,
                                      size: 35,
                                    ),
                                    Text(
                                      '${snapshot.data[index].approvalStatus ? 'Onaylandı' : 'Onay Bekliyor'}',
                                      style: GoogleFonts.lemonada(
                                          fontSize:
                                              Constants.getHeight(context) /
                                                  71.1),
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
              style: GoogleFonts.sriracha(
                  fontSize: Constants.getHeight(context) / 59.25),
            ),
            Container(
                alignment: Alignment.centerLeft,
                height: Constants.getHeight(context) / 23.7,
                width: Constants.getWidth(context) / 2.74,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 8)
                    ]),
                child: Text(
                  data,
                  style: GoogleFonts.robotoSlab(
                      fontSize: Constants.getHeight(context) / 59.25),
                )),
          ],
        ),
      ),
    );
  }
}
