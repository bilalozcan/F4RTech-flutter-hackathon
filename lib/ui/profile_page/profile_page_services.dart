import 'package:education/models/User.dart' as usr;
import 'package:education/services/firestoredbservice.dart';

Future<usr.User> futureCurrentUser(Future<usr.User> user) async {
  return await user;
}

class ProfilePageModel {
  bool listType =
      true; //false = eklenen öğrenciler listesi true = yapılan bağışlar listesi
  var user;
  var firestoreDBService = FirestoreDBService();
  Future getUser() async {
    try {
      user = await firestoreDBService.getCurrentUser();
      return user;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
