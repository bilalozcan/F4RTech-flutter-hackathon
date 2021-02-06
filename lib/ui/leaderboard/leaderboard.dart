import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final _firestoreDBService = FirestoreDBService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTable.swatch1,
      appBar: AppBar(
        shadowColor: ColorTable.swatch2.withOpacity(0),
        backgroundColor: Colors.white.withOpacity(0),
        title: Text(
          'Liderlik Tablosu',
          style: GoogleFonts.poppins(
              fontSize: Constants.getHeight(context) / 39.5,
              color: ColorTable.textColor,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: Constants.getWidth(context) / 1.17,
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: Constants.getHeight(context) / 17.775,
                        width: Constants.getWidth(context) / 1.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'İSİM',
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        Constants.getHeight(context) / 39.5,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'PUAN',
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        Constants.getHeight(context) / 39.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Container(
                        color: Colors.white,
                        width: Constants.getWidth(context) / 1.17,
                        height: Constants.getHeight(context) / 1.4,
                        child: Stack(
                          children: [
                            FutureBuilder(
                                future: _firestoreDBService.getUsers(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: LeaderList(index, snapshot),
                                          );
                                        });
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget LeaderList(int index, var snapshot) {
    var color = ColorTable.swatch4;
    var borderWidth = 0;
    var photoicon = '';

    if (index == 0) {
      color = 'f0d11d'.toColor();
      borderWidth = 1;
      photoicon = 'assets/1st.png';
    } else if (index == 1) {
      color = 'e61616'.toColor();
      borderWidth = 1;
      photoicon = 'assets/2nd.png';
    } else if (index == 2) {
      color = '233856'.toColor();
      borderWidth = 1;
      photoicon = 'assets/3th.png';
    }
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: Constants.getHeight(context) / 14.22,
              decoration: BoxDecoration(
                  color: ColorTable.swatch4.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border:
                      Border.all(width: borderWidth.toDouble(), color: color),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.1),
                      blurRadius: 8,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Text(
                      snapshot.data[index]['fullname'],
                      style: GoogleFonts.podkova(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: Constants.getHeight(context) / 17.75,
                          width: Constants.getWidth(context) / 4.11,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text(
                            "${snapshot.data[index]['point'] < 99999 ? snapshot.data[index]['point'] : "99999+"}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: Constants.getHeight(context) / 28.44),
                          )),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Image.asset(
                          'assets/giphy.webp',
                          height: 150,
                          width: 75,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider()
          ],
        ),
        Positioned(
          top: -Constants.getHeight(context) / 20.31,
          left: -Constants.getWidth(context) / 11.74,
          child: Image.asset(
            photoicon,
            fit: BoxFit.contain,
            height: Constants.getHeight(context) / 6.18,
            width: Constants.getWidth(context) / 3.57,
          ),
        ),
      ],
    );
  }
}
