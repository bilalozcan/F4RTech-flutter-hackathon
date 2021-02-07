import 'package:education/services/authentication.dart';
import 'package:education/ui/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/services/firestoredbservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

import '../background.dart';
import 'leader_board_models.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final _firestoreDBService = FirestoreDBService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundContainer(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                customAppBar(context),
                FutureBuilder(
                  future: _firestoreDBService.getUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return Column(
                        children: [
                          Container(
                            height: Constants.getHeight(context) * 0.40,
                            width: Constants.getWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    theFirstTree(
                                      context,
                                      '2',
                                      'assets/2nd.png',
                                      Constants.getHeight(context) * 0.12,
                                      snapshot.data.length < 2 ? '-' : snapshot.data[1]['fullname'],
                                      snapshot.data.length < 2 ? '-' : snapshot.data[1]['point'].toString(),
                                      FontAwesomeIcons.chevronUp,
                                      -Constants.getHeight(context) * 0.24,
                                      -Constants.getHeight(context) * 0.01,
                                      Constants.getHeight(context) * 0.045,
                                    ),
                                    theFirstTree(
                                      context,
                                      '3',
                                      'assets/3th.png',
                                      Constants.getHeight(context) * 0.12,
                                      snapshot.data.length < 3 ? '-' : snapshot.data[2]['fullname'],
                                      snapshot.data.length < 3 ? '-' : snapshot.data[2]['point'].toString(),
                                      FontAwesomeIcons.chevronDown,
                                      -Constants.getHeight(context) * 0.01,
                                      -Constants.getHeight(context) * 0.24,
                                      Constants.getHeight(context) * 0.045,
                                    ),
                                    theFirstTree(
                                      context,
                                      '1',
                                      'assets/1st.png',
                                      Constants.getHeight(context) * 0.16,
                                      snapshot.data[0]['fullname'],
                                      snapshot.data[0]['point'].toString(),
                                      FontAwesomeIcons.crown,
                                      -Constants.getHeight(context) * 0.2,
                                      -Constants.getHeight(context) * 0.2,
                                      -Constants.getHeight(context) * 0.016,
                                    ),
                                    Positioned(
                                      child: Column(
                                        children: [],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: snapshot.data.length <= 3
                                ? 0
                                : snapshot.data.length > 50
                                    ? 47
                                    : snapshot.data.length - 3,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return listViewContainer(
                                  context, index, snapshot.data[index + 3]['fullname'], snapshot.data[index + 3]['point'].toString());
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: LoadingBouncingGrid.square(
                          size: 30,
                          backgroundColor: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
