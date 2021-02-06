import 'package:education/services/firestoredbservice.dart';

class ProfilePageModel {
  bool listType =
      true; //false = eklenen öğrenciler listesi true = yapılan bağışlar listesi
  var user = FirestoreDBService().getCurrentUser();
}
