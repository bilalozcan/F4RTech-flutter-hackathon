import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';
import 'package:education/models/User.dart';

class Donation {
  double _amount; //Turkish Liras
  DateTime _dateDonation;
  String _donorID; //String or id or User class
  Student _donorRecipientID; //??

  Donation.fromMap(Map<String, dynamic> parsedMap)
      : _amount = parsedMap["amount"],
        _dateDonation = (parsedMap["datedonation"] as Timestamp).toDate(),
        _donorID = parsedMap["donorid"],
        _donorRecipientID = parsedMap["donorrecipientid"];

  Map<String, dynamic> toMap() {
    return {
      "amount": _amount,
      "datedonation": _dateDonation,
      "donorid": _donorID,
      "donorrecipientid": _donorRecipientID,
    };
  }
}
