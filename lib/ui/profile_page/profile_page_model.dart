import 'package:education/services/firestoredbservice.dart';

class ProfilePageModel {
  bool listType =
      true; //false = eklenen öğrenciler listesi true = yapılan bağışlar listesi
  var user;
  getUser() async {
    try {
      user = await FirestoreDBService().getCurrentUser();
      return user;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
