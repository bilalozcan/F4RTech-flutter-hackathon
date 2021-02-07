import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/ui/background.dart';
import 'package:education/ui/webview_page/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:education/models/User.dart' as usr;
import 'package:education/models/Student.dart';

class DonatePage extends StatefulWidget {
  final usr.User user;
  final Student student;

  DonatePage(this.user, this.student);

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    var list = <Widget>[];
    for (var i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        backgroundContainer(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.90,
                        child: PageView(
                          allowImplicitScrolling: true,
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            pageWidgets(
                                context,
                                'Destek Paketi 1',
                                'Çorbada sizin de tuzunuz bulunsun.',
                                'assets/12.png',
                                'https://www.shopier.com/ShowProductNew/products.php?id=5944810',
                                10),
                            pageWidgets(
                                context,
                                'Destek Paketi 2',
                                'Çorbada sizin de tuzunuz bulunsun.',
                                'assets/11.png',
                                'https://shopier.com/5944854',
                                25),
                            pageWidgets(
                                context,
                                'Destek Paketi 3',
                                'Çorbada sizin de tuzunuz bulunsun.',
                                'assets/10.png',
                                'https://www.shopier.com/ShowProductNew/products.php?id=5949650',
                                50),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget pageWidgets(
      BuildContext context, text, snippet, imageUrl, link, bagis) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30, top: 25),
        child: Container(
          height: Constants.getHeight(context) * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  photo(imageUrl),
                  textandInfo(context, text, snippet),
                  SizedBox(
                    height: 5,
                  ),
                  lightBar(context),
                ],
              ),
              packageDetail(bagis),
              goToLink(link, text, context, bagis)
            ],
          ),
        ),
      ),
    );
  }

  Widget goToLink(link, title, BuildContext context, bagis) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebviewPage(
                        link, title, bagis, widget.student, widget.user)));
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [ColorTable.swatch3, ColorTable.swatch4],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Destek Verin',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget packageDetail(bagis) {
    return Text(
      '♦ Öğrencimizin eğitimine $bagis TL destek vererek katkıda bulunun.',
      textAlign: TextAlign.start,
      style: TextStyle(
          height: 1.7,
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget lightBar(BuildContext context) {
    return Container(
      height: 3,
      width: MediaQuery.of(context).size.width < 350
          ? MediaQuery.of(context).size.width * 0.9
          : MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10, offset: Offset(0, 0), color: Colors.blue.shade800)
      ], color: ColorTable.swatch1, borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget textandInfo(BuildContext context, text, snippet) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            snippet,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget photo(imageUrl) {
    return Center(
      child: Image(
        image: AssetImage(
          imageUrl,
        ),
        height: 140,
        width: 140,
      ),
    );
  }
}
