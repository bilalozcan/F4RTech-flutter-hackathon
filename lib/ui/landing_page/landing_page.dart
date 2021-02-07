import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          Scaffold(
            backgroundColor: Color(0xffe8ffff),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Constants.getWidth(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: Constants.getWidth(context) * 0.5),
                              child: Text('Yardımseverlerle, öğrencileri buluşturduğumuz uygulamamıza hoş geldin.',
                                  style: GoogleFonts.roboto(color: ColorTable.textColor, fontWeight: FontWeight.w700, fontSize: 15)),
                            ),
                            Image.asset(
                              'assets/landing1.png',
                              height: Constants.getHeight(context) / 2.1,
                            ),
                          ],
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
                          'Back to School',
                          style: GoogleFonts.roboto(
                              color: ColorTable.textColor, fontWeight: FontWeight.w900, fontSize: Constants.getHeight(context) * 0.037),

                        ),
                        Image.asset(
                          'assets/login.png',
                          height: Constants.getHeight(context) / 4.74,
                        ),
                        textRow('Keşfetmeye hazır mısın?'),
                        ButtonInkWell(() {
                          page();
                        }, 'Keşfet'),
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
    );
  }

  // ignore: always_declare_return_types
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
            color: ColorTable.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => ClampingScrollPhysics();
}
