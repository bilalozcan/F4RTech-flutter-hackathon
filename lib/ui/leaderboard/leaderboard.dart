import 'package:flutter/material.dart';
import 'package:education/services/firestoredbservice.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final _firestoreDBService = FirestoreDBService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _firestoreDBService.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data[index]['fullname']),
                    subtitle: Text(snapshot.data[index]['point'].toString()),
                  ));
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
