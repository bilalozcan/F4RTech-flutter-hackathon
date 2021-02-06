import 'package:education/app/colors/colors.dart';
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
              fontSize: 18,
              color: ColorTable.textColor,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 350,
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
                        height: 40,
                        width: 350.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'İSİM',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'PUAN',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                        width: 350.0,
                        height: 600.0,
                        child: Stack(
                          children: [
                            Positioned(
                              top: -50,
                              right: 0,
                              child: Image.asset(
                                'assets/giphy.webp',
                                height: 600.0,
                                width: 400.0,
                              ),
                            ),
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
      borderWidth = 5;
      photoicon = 'assets/1st.png';
    } else if (index == 1) {
      color = 'e61616'.toColor();
      borderWidth = 5;
      photoicon = 'assets/2nd.png';
    } else if (index == 2) {
      color = '233856'.toColor();
      borderWidth = 5;
      photoicon = 'assets/3th.png';
    }
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ColorTable.swatch4.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border:
                      Border.all(width: borderWidth.toDouble(), color: color),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.2), blurRadius: 8)
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 40,
                      width: 100,
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
                            fontWeight: FontWeight.w700, fontSize: 25),
                      )),
                    ),
                  )
                ],
              ),
            ),
            Divider()
          ],
        ),
        Positioned(
          top: -35,
          left: -35,
          child: Image.asset(
            photoicon,
            fit: BoxFit.contain,
            height: 115.0,
            width: 115.0,
          ),
        ),
      ],
    );
  }
}
/*
* Container(
      height: 50,
      decoration: BoxDecoration(
          color: ColorTable.swatch7.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(snapshot.data[index]['fullname'],style: GoogleFonts.podkova(
                fontWeight: FontWeight.w500
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Container(
              height: 40,
              width: 100,
              decoration:BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),

              ),
              child: Center(child: Text("${snapshot.data[index]['point']<99999 ? snapshot.data[index]['point']: "99999+"}",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 25
              ),)),

            ),
          )
        ],
      ),
    );
* */
