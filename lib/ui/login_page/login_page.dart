import 'package:education/app/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/ui/login_page/login_page_model.dart';
import 'package:education/ui/login_page/login_page_services.dart';
import 'package:education/ui/sign_up_page/sign_up_page.dart';
import 'package:education/widget/button/buttonInkWell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageModel model = LoginPageModel();
  LoginPageServices _services = LoginPageServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTable.backroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Constants.getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/landing2.png",
                    height: Constants.getHeight(context) / 2.1,
                  ),
                ],
              ),
            ),
            Container(
              height: Constants.getHeight(context) / 2,
              width:Constants.getWidth(context) / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hoş geldiniz",
                    style: GoogleFonts.roboto(
                        color: ColorTable.textColor,
                        fontWeight: FontWeight.w900,
                        fontSize: Constants.getHeight(context) / 20),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Constants.getHeight(context) / 12.93,
                          decoration: BoxDecoration(
                            color: Color(0xffdcbe9b).withOpacity(0.5),
                          ),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: model.email,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "E-posta",
                                  contentPadding: EdgeInsets.only(left: 8)),
                              //autofocus: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Container(
                            height: Constants.getHeight(context) / 12.93,
                            decoration: BoxDecoration(
                              color: Color(0xffdcbe9b).withOpacity(0.5),
                            ),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: model.password,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Şifre",
                                    contentPadding: EdgeInsets.only(left: 8)),
                                //autofocus: true,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 2),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Text(
                                "Şifreni mi Unuttun?",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff264dfa), fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonInkWell(() {
                    _services.signIn(
                        context, model.email.text, model.password.text);
                  }, "Giriş"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hesabın Yok mu?",
                        style: GoogleFonts.poppins(
                          color: ColorTable.textColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                "Kayıt ol",
                                style: GoogleFonts.poppins(
                                  color: Color(0xff264dfa),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
