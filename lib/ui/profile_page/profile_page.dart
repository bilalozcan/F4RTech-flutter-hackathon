import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/services/authentication.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:education/ui/profile_page/profile_page_model.dart';
import 'package:education/ui/profile_page/profile_page_services.dart';
import 'package:education/widget/MyClipper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:education/models/User.dart' as usr;
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageModel model = ProfilePageModel();
  @override
  Widget build(BuildContext context) {
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

  UserInfoWidget(String s, String username) {
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

  UserInfoWidget2(String info, String userInfo) {
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
        ],
      ),
    );
  }

  Listwidget(ProfilePageModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: Constants.getHeight(context) / 2.5,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: ColorTable.swatch1.withOpacity(0.2), blurRadius: 10)
        ]),
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
                    )),
                  ),
                )
              ],
            ),
            ListMethod(5),
          ],
        ),
      ),
    );
  }

  ListMethod(int itemCount) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  model.listType == false ? AddStudentWidget() : YApilanBagis(),
            );
          }),
    );
  }

  AddStudentWidget() {
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

  CheckStatus(int a) {
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

  YApilanBagis() {
    return Container(
      width: Constants.getWidth(context) / 2,
      height: Constants.getHeight(context) / 8,
      color: ColorTable.swatch2.withOpacity(0.5),
    );
  }
}
