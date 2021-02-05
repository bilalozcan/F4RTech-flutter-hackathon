import 'package:education/ui/login_page/signIn_page/sign_in_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInPageModel model = SignInPageModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: 'ffdfc1'.toColor(),
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kayıt Ol",
                  style: GoogleFonts.russoOne(
                      fontSize: MediaQuery.of(context).size.height / 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputWidget(model.fullname, context, "İsim-Soyisim",
                        TextInputType.name),
                    InputWidget(model.username, context, "Kullanıcı adı",
                        TextInputType.text),
                    InputWidget(model.phone, context, "Telefon Numarası",
                        TextInputType.numberWithOptions(decimal: true)),
                    InputWidget(model.email, context, "E-posta",
                        TextInputType.emailAddress),
                    InputWidget(model.password, context, "Password",
                        TextInputType.visiblePassword),
                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Material(
                        color: Colors.white.withOpacity(0),
                        child: InkWell(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                          splashColor: Colors.red,
                          onTap: (){
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/12.93,
                            width: MediaQuery.of(context).size.width/1.82,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Kayıt Ol",
                                  style: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.height/35.55,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_outlined,
                                  size: MediaQuery.of(context).size.height/20,
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
        height: MediaQuery.of(context).size.height / 12.93,
        decoration: BoxDecoration(
            color: 'dcbe9b'.toColor().withOpacity(0.5),
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
