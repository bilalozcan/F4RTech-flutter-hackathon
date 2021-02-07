import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/ui/background.dart';
import 'package:education/ui/profile_page/profile_page_model.dart';
import 'package:education/widget/MyClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageModel model = ProfilePageModel();

  @override
  Widget build(BuildContext context) {
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
                                  color: ColorTable.swatch3.withOpacity(0.5),
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
                              //burası ranklar verildikten sonra widgetlara ayrılacak
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
                                          borderRadius:
                                              BorderRadius.circular(52),
                                          color: ColorTable.swatch3,
                                        ),
                                      ),
                                      ClipRRect(
                                        child: Image.asset(
                                          'assets/5.png',
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
                            Listwidget(model),
                          ],
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
                })),
      ],
    );
  }

  Container topInfo(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      width: Constants.getWidth(context) * 0.80,
      height: Constants.getHeight(context) * 0.17,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            offset: Offset(0.1, 0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: Constants.getHeight(context) * 0.01,
          ),
          userInfo('', snapshot.data.fullname, 18.0, FontWeight.w800),
          Divider(
            height: 5,
            endIndent: 50,
            indent: 50,
            color: Colors.black,
          ),
          userInfo('E-posta: ', snapshot.data.email, 12.0, FontWeight.w500),
          Divider(
            height: 5,
            endIndent: 50,
            indent: 50,
            color: Colors.black,
          ),
          userInfo(
              'Telephone: ', snapshot.data.telephone, 12.0, FontWeight.w500),
        ],
      ),
    );
  }

  Text userInfo(String text, detail, size, weight) {
    return Text(
      '$text ${detail}',
      style: GoogleFonts.poppins(
          color: ColorTable.textColor.withOpacity(1),
          fontSize: size,
          fontWeight: weight),
    );
  }

  Padding Listwidget(ProfilePageModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: Constants.getHeight(context) / 2,
        decoration: BoxDecoration(),
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
                    height: Constants.getHeight(context) / 20,
                    width: Constants.getWidth(context) / 2.74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: model.listType == false
                            ? Border.all(width: 2, color: ColorTable.swatch6)
                            : Border.all(width: 2, color: ColorTable.swatch4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8)
                        ]),
                    child: Center(
                        child: Text(
                      'Eklenen Öğrenciler',
                      style: GoogleFonts.poppins(
                          color: ColorTable.textColor, fontSize: 14),
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
                    height: Constants.getHeight(context) / 20,
                    width: Constants.getWidth(context) / 2.74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: model.listType == true
                            ? Border.all(width: 2, color: ColorTable.swatch6)
                            : Border.all(width: 2, color: ColorTable.swatch4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8)
                        ]),
                    child: Center(
                        child: Text(
                      'Yapılan  Bağışlar',
                      style: GoogleFonts.poppins(
                          color: ColorTable.textColor, fontSize: 14),
                    )),
                  ),
                )
              ],
            ),
            ListMethod(model.listType == false
                ? model.user.listOfPost.length
                : model.user.listOfDonationsMade.length),
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
              child: model.listType == false
                  ? AddStudentWidget(index)
                  : YapilanBagis(index),
            );
          }),
    );
  }

  Widget AddStudentWidget(int index) {
    return Container(
      width: Constants.getWidth(context) / 2,
      height: Constants.getHeight(context) / 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
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
                    future: model.firestoreDBService
                        .getStudent(model.user.listOfPost[index]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.fullname,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorTable.textColor,
                              fontWeight: FontWeight.w600),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
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
          Text('Onaylandı'),
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
          Text('Onaylanmadı'),
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
          Text('Bekliyor'),
        ],
      );
    }
  }

  Container YapilanBagis(index) {
    return Container(
      width: Constants.getWidth(context) / 2,
      height: Constants.getHeight(context) / 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
      child: FutureBuilder(
        future: model.firestoreDBService
            .getDonations(model.user.listOfDonationsMade[index]),
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
    );
  }
}
