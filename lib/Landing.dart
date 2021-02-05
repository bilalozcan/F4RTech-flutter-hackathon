import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  PageController _pageController = PageController();
  TextEditingController email = TextEditingController();

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: [
            Scaffold(
              backgroundColor: Color(0xffffdfc1),
              body: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              child: Text(
                                  "Yardımseverlerle, öğrencileri buluşturduğumuz uygulamamıza hoş geldin.",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                            ),
                            Image.asset(
                              "assets/landing1.png",
                              height: MediaQuery.of(context).size.height / 2.1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "F 4 R - E D U C A T I O N",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 25),
                        ),
                        Image.asset(
                          "assets/login.png",
                          height: 150,
                        ),
                        textRow("Keşfetmeye hazır mısın?"),
                        buttonInkWell(context, 2, "Keşfet"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xffffdfc1),
              body: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/landing2.png",
                          height: MediaQuery.of(context).size.height / 2.1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoş geldiniz",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.height / 20),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 12.93,
                                decoration: BoxDecoration(
                                  color: Color(0xffdcbe9b).withOpacity(0.5),
                                ),
                                child: Center(
                                  child: TextField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    controller: email,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "E-posta",
                                        contentPadding:
                                            EdgeInsets.only(left: 8)),
                                    autofocus: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      12.93,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdcbe9b).withOpacity(0.5),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: email,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Şifre",
                                          contentPadding:
                                              EdgeInsets.only(left: 8)),
                                      autofocus: true,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 2),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Text(
                                      "Şifreni mi Unuttun?",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff264dfa),
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buttonInkWell(context, 2, "Giriş"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Hesabın Yok mu?",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GestureDetector(
                                    onTap: () {},
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
          ],
        ),
      ),
    );
  }

  Row textRow(text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buttonInkWell(BuildContext context, page, text) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        splashColor: Colors.red,
        onTap: () {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 12.93,
          width: MediaQuery.of(context).size.width / 1.82,
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
                text,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height / 35.55,
                    color: Colors.black,
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
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
