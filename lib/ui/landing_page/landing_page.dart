import 'package:education/ui/login_page/login_page.dart';
import 'package:education/widget/button/buttonInkWell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
              body: SingleChildScrollView(
                child: Column(
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
                          ButtonInkWell( () {
                            page();
                          },"Keşfet"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LoginPage()
          ],
        ),
      ),
    );
  }
  page() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeIn,
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

}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
