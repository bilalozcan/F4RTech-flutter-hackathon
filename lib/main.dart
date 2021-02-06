import 'package:education/services/authentication.dart';
import 'package:education/ui/home_page/ShareContent.dart';
import 'package:education/ui/landing_page/landing_page.dart';
<<<<<<< Updated upstream
=======
import 'package:education/ui/navigationBar.dart';
>>>>>>> Stashed changes
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _authentication.currentUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
