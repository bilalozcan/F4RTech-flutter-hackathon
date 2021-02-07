import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/ui/login_page/login_page_model.dart';
import 'package:education/ui/login_page/login_page_services.dart';
import 'package:education/ui/sign_up_page/sign_up_page.dart';
import 'package:education/widget/button/buttonInkWell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../registration_page_input_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageModel model = LoginPageModel();
  final LoginPageServices _services = LoginPageServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTable.swatch1,
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
                    'assets/landing2.png',
                    height: Constants.getHeight(context) / 2.1,
                  ),
                ],
              ),
            ),
            Container(
              height: Constants.getHeight(context) / 2,
              width: Constants.getWidth(context) / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoş geldiniz',
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
                        InputWidget(model.email, context, 'E-posta',
                            TextInputType.emailAddress,
                            validator: _services.emailValidator),
                        InputWidget(model.password, context, 'Şifre',
                            TextInputType.visiblePassword,
                            validator: _services.passwordValidator),
                      ],
                    ),
                  ),
                  ButtonInkWell(() {
                    _services.signIn(
                        context, model.email.text, model.password.text);
                  }, 'Giriş'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hesabın Yok mu?',
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                'Kayıt ol',
                                style: GoogleFonts.poppins(
                                  color: ColorTable.swatch4,
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
