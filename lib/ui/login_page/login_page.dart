
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:'ffdfc1'.toColor() ,
      body:Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height/20,
            left: MediaQuery.of(context).size.width/8.22,
            right: MediaQuery.of(context).size.width/5.13,
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hoşgeldiniz",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: MediaQuery.of(context).size.height/20
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/12.93,
                          decoration: BoxDecoration(
                            color:'dcbe9b'.toColor().withOpacity(0.5),
                          ),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              controller: email,
                              decoration: InputDecoration(border: InputBorder.none,hintText: "E-posta",contentPadding: EdgeInsets.only(left:8)),
                              autofocus: true,

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:18.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/12.93,
                            decoration: BoxDecoration(
                              color:'dcbe9b'.toColor().withOpacity(0.5),
                            ),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller: email,
                                decoration: InputDecoration(border: InputBorder.none,hintText: "Şifre",contentPadding: EdgeInsets.only(left:8)),
                                autofocus: true,

                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0,left:2),
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              child: Text("Şifreni mi Unuttun?",style: GoogleFonts.poppins(
                                  color:'264dfa'.toColor(),
                                  fontSize: 13
                              ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Ink(

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
                              "Giriş",
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
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Hesabın Yok mu?",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),),
                        GestureDetector(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: GestureDetector(
                                onTap: (){},
                                child: Text(
                                  "Kayıt ol"
                                  ,style: GoogleFonts.poppins(
                                  color: '264dfa'.toColor(),
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
