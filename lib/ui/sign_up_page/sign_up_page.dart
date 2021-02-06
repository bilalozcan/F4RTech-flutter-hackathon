import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';

import 'package:education/ui/sign_up_page/sign_up_page_model.dart';
import 'package:education/ui/sign_up_page/sign_up_page_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignInPageModel model = SignInPageModel();
  SignUpPageServices _services = SignUpPageServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: Constants.getWidth(context),
          height: Constants.getHeight(context),
          color: ColorTable.swatch2,
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kayıt Ol",
                  style: GoogleFonts.russoOne(
                      fontSize: Constants.getHeight(context) / 25,
                      color: ColorTable.textColor,
                      fontWeight: FontWeight.w500),
                ),
                Column(
                  children: [
                    InputWidget(model.fullname, context, "İsim-Soyisim",
                        TextInputType.name),
                    InputWidget(model.username, context, "Kullanıcı adı",
                        TextInputType.text),
                    InputWidget(model.phone, context, "Telefon Numarası",
                        TextInputType.numberWithOptions(decimal: true)),
                    InputWidget(model.email, context, "E-posta",
                        TextInputType.emailAddress),
                    InputWidget(model.password, context, "Şifre",
                        TextInputType.visiblePassword),
                    InputWidget(model.passwordAgain, context, "Şifre tekrar",
                        TextInputType.visiblePassword),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Material(
                        color: Colors.white.withOpacity(0),
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          splashColor: Colors.red,
                          onTap: () {
                            _services.signUp(
                                context,
                                model.email.text,
                                model.password.text,
                                model.passwordAgain.text,
                                model.fullname.text,
                                model.username.text,
                                model.phone.text);
                          },
                          child: Container(
                            height: Constants.getHeight(context) / 12.93,
                            width: Constants.getWidth(context) / 1.82,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Kayıt Ol",
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          Constants.getHeight(context) / 35.55,
                                      color: ColorTable.textColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_outlined,
                                  size: MediaQuery.of(context).size.height / 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget InputWidget(TextEditingController controller, BuildContext context,
      String string, TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        height: Constants.getHeight(context) / 12.93,
        decoration: BoxDecoration(
            color: ColorTable.swatch1.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: TextField(
            keyboardType: textInputType,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: string,
                contentPadding: EdgeInsets.only(left: 8)),
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
