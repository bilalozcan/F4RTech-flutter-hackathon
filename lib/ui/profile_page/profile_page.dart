import 'package:education/services/authentication.dart';
import 'package:education/ui/profile_page/profile_page_services.dart';
import 'package:flutter/material.dart';
import 'package:education/models/User.dart' as usr;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  usr.User currentUser;
  Authentication _authentication;

  @override
  void initState() {
    super.initState();
    //currentUser = futureCurrentUser(_authentication.currentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(body: Container(child: Text(currentUser.fullname)));
  }
}
