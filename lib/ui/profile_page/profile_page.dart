import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
<<<<<<< Updated upstream
=======

import 'package:education/app/helper.dart';
import 'package:education/services/authentication.dart';

import 'package:education/ui/background.dart';
import 'package:education/ui/login_page/login_page.dart';

>>>>>>> Stashed changes
import 'package:education/ui/profile_page/profile_page_model.dart';
import 'package:education/widget/MyClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageModel model = ProfilePageModel();
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: model.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyCustomClipper(),
                          child: Container(
                            color: ColorTable.swatch1,
                            width: double.infinity,
                            height: Constants.getHeight(context) / 4,
                          ),
                        ),
                        Positioned(
                          top: Constants.getHeight(context) / 8,
                          left: Constants.getWidth(context) / 2.4,
                          right: Constants.getWidth(context) / 2.4,
                          child: Container(
                            width: Constants.getWidth(context) / 5.48,
                            height: Constants.getHeight(context) / 9.48,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                          ),
                        ),
                        AppBar(
                          shadowColor: ColorTable.swatch2.withOpacity(0),
                          backgroundColor: Colors.white.withOpacity(0),
                          title: Text(
                            'Profil',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: ColorTable.textColor,
                                fontWeight: FontWeight.w600),
                          ),
=======
    return Stack(
      children: [
        backgroundContainer(context),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: FutureBuilder(
                future: model.getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          width: Constants.getWidth(context),
                          height: Constants.getHeight(context) * 0.4,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              ClipPath(
                                clipper: MyCustomClipper(),
                                child: Container(
                                  child: Image.asset(
                                    'assets/bagis.png',
                                  ),
                                  color: ColorTable.swatch4.withOpacity(0.6),
                                  width: double.infinity,
                                  height: Constants.getHeight(context) / 4,
                                ),
                              ),
                              Positioned(
                                bottom: 32,
                                right: 20,
                                child: topInfo(context, snapshot),
                              ),
                              Positioned(
                                right: 15,
                                top: Constants.getHeight(context) * 0.16,
                                child: Image.asset(
                                  'assets/donation.png',
                                  width: 50,
                                ),
                              ),
                              Positioned(
                                  top: Constants.getHeight(context) / 7,
                                  left: 10,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 105,
                                        height: 105,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(52),
                                          color: ColorTable.swatch3,
                                        ),
                                      ),
                                      ClipRRect(
                                        child: Image.asset(
                                          '${Helper.UserIconLevel(snapshot.data)[1]}',
                                          height: 100,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            FlatButton(
                              color: ColorTable.swatch4.withOpacity(0.6),
                              child: Text(
                                'Çıkış yap',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                var _firebaseAuth = Authentication();
                                _firebaseAuth.signOut();
                                Navigator.of(context)
                                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                              },
                            ),
                            SizedBox(height: 10),
                            Listwidget(model),
                          ],
>>>>>>> Stashed changes
                        )
                      ],
                    ),
                    Container(
                      height: Constants.getHeight(context) -
                          Constants.getHeight(context) / 4,
                      width: Constants.getWidth(context),
                      child: Column(
                        children: [
                          UserInfoWidget(
                              snapshot.data.fullname, snapshot.data.username),
                          UserInfoWidget2('E-Posta', snapshot.data.email),
                          UserInfoWidget2('Telefon', snapshot.data.telephone),
                          Listwidget(model),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
            }));
  }

  Container UserInfoWidget(String s, String username) {
    return Container(
      width: Constants.getWidth(context) / 1.5,
      height: Constants.getHeight(context) / 12,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: ColorTable.swatch1,
              blurRadius: 8,
            )
          ]),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              s,
              style: GoogleFonts.poppins(
                  color: ColorTable.textColor.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '@$username',
              style: GoogleFonts.poppins(
                  color: ColorTable.textColor.withOpacity(0.3),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Padding UserInfoWidget2(String info, String userInfo) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info,
            style:
                GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: Constants.getWidth(context) / 1.2,
              height: Constants.getHeight(context) / 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: ColorTable.swatch1.withOpacity(0.5),
                    blurRadius: 8,
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  userInfo,
                  style: GoogleFonts.poppins(
                      color: ColorTable.textColor.withOpacity(0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
<<<<<<< Updated upstream
=======
          userInfo('Telephone: ', snapshot.data.telephone, 12.0, FontWeight.w500),
>>>>>>> Stashed changes
        ],
      ),
    );
  }

<<<<<<< Updated upstream
=======
  Text userInfo(String text, detail, size, weight) {
    return Text(
      '$text ${detail}',
      style: GoogleFonts.poppins(color: ColorTable.textColor.withOpacity(1), fontSize: size, fontWeight: weight),
    );
  }

>>>>>>> Stashed changes
  Padding Listwidget(ProfilePageModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
<<<<<<< Updated upstream
        height: Constants.getHeight(context) / 2.5,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: ColorTable.swatch1.withOpacity(0.2), blurRadius: 10)
        ]),
=======
        height: Constants.getHeight(context) * 0.45,
>>>>>>> Stashed changes
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      model.listType = false;
                    });
                  },
                  child: Container(
                    height: Constants.getHeight(context) / 28.44,
                    width: Constants.getWidth(context) / 2.74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: model.listType == false
<<<<<<< Updated upstream
                            ? Border.all(width: 2, color: ColorTable.swatch7)
                            : Border.all(
                                width: 2,
                                color: ColorTable.swatch7.withOpacity(0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8)
                        ]),
                    child: Center(
                        child: Text(
                      'Eklenen Öğrenciler',
                      style: GoogleFonts.poppins(
                          color: ColorTable.textColor, fontSize: 11),
=======
                            ? Border.all(width: 2, color: ColorTable.swatch6)
                            : Border.all(width: 2, color: ColorTable.swatch4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)]),
                    child: Center(
                        child: Text(
                      'Eklenen Öğrenciler',
                      style: GoogleFonts.poppins(color: ColorTable.textColor, fontSize: 14),
>>>>>>> Stashed changes
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      model.listType = true;
                    });
                  },
                  child: Container(
                    height: Constants.getHeight(context) / 28.44,
                    width: Constants.getWidth(context) / 2.74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: model.listType == true
<<<<<<< Updated upstream
                            ? Border.all(width: 2, color: ColorTable.swatch7)
                            : Border.all(
                                width: 2,
                                color: ColorTable.swatch7.withOpacity(0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8)
                        ]),
                    child: Center(
                        child: Text(
                      'Yapılan  Bağışlar',
                      style: GoogleFonts.poppins(
                          color: ColorTable.textColor, fontSize: 11),
=======
                            ? Border.all(width: 2, color: ColorTable.swatch6)
                            : Border.all(width: 2, color: ColorTable.swatch4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)]),
                    child: Center(
                        child: Text(
                      'Yapılan  Bağışlar',
                      style: GoogleFonts.poppins(color: ColorTable.textColor, fontSize: 14),
>>>>>>> Stashed changes
                    )),
                  ),
                )
              ],
            ),
<<<<<<< Updated upstream
            ListMethod(5),
=======
            ListMethod(model.listType == false ? model.user.listOfPost.length : model.user.listOfDonationsMade.length),
>>>>>>> Stashed changes
          ],
        ),
      ),
    );
  }

  Expanded ListMethod(int itemCount) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
<<<<<<< Updated upstream
              child:
                  model.listType == false ? AddStudentWidget() : YApilanBagis(),
=======
              child: model.listType == false ? AddStudentWidget(index) : YapilanBagis(index),
>>>>>>> Stashed changes
            );
          }),
    );
  }

<<<<<<< Updated upstream
  Padding AddStudentWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: Constants.getWidth(context) / 2,
        height: Constants.getHeight(context) / 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: ColorTable.swatch2.withOpacity(0.8), blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: Constants.getHeight(context) / 29.5,
                    height: Constants.getHeight(context) / 29.5,
                    decoration: BoxDecoration(
                      color: ColorTable.swatch4.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'name',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorTable.textColor,
                          fontWeight: FontWeight.w600),
                    ),
=======
  Widget AddStudentWidget(int index) {
    return Container(
      width: Constants.getWidth(context) / 2,
      height: Constants.getHeight(context) / 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: Constants.getHeight(context) / 29.5,
                  height: Constants.getHeight(context) / 29.5,
                  decoration: BoxDecoration(
                    color: Color(0xff3c8f7c),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FutureBuilder(
                    future: model.firestoreDBService.getStudent(model.user.listOfPost[index]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.fullname,
                          style: GoogleFonts.poppins(fontSize: 15, color: ColorTable.textColor, fontWeight: FontWeight.w600),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
>>>>>>> Stashed changes
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CheckStatus(3),
            )
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Row CheckStatus(int a) {
    if (a == 1) {
      return Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          Text('ONAYLANDI'),
        ],
      );
    }
    if (a == 2) {
      return Row(
        children: [
          Icon(
            Icons.close,
            color: Colors.red,
          ),
          Text('ONAYLANMADI'),
        ],
      );
    }
    if (a == 3) {
      return Row(
        children: [
          Icon(
            Icons.linear_scale,
            color: Colors.yellow,
          ),
          Text('BEKLİYOR'),
        ],
      );
    }
  }

  Container YApilanBagis() {
    return Container(
      width: Constants.getWidth(context) / 2,
<<<<<<< Updated upstream
      height: Constants.getHeight(context) / 8,
      color: ColorTable.swatch2.withOpacity(0.5),
=======
      height: Constants.getHeight(context) / 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
      child: FutureBuilder(
        future: model.firestoreDBService.getDonations(model.user.listOfDonationsMade[index]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: Constants.getHeight(context) / 29.5,
                        height: Constants.getHeight(context) / 29.5,
                        decoration: BoxDecoration(
                          color: Color(0xff3c8f7c),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${snapshot.data.amount} ₺',
                          style: GoogleFonts.poppins(fontSize: 15, color: ColorTable.textColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CheckStatus(1),
                )
              ],
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
>>>>>>> Stashed changes
    );
  }
}
