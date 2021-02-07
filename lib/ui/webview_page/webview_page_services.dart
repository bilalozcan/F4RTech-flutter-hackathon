import 'package:education/models/User.dart' as usr;
import 'package:education/services/firestoredbservice.dart';
import 'package:education/models/Donation.dart';
import 'package:education/models/Student.dart';

class WebviewPageServices{
  FirestoreDBService firestoreDBService = FirestoreDBService();
  Future<dynamic> addDonation(usr.User donor, Student student, int amount) async {
    var donationName = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    var donation = Donation(donationName, amount, DateTime.now(), donor.uid, student.reference.id);
    var result = await firestoreDBService.addDonation(donation, donor, student, donationName);
    if(result){
      return result;
    }
  }
}