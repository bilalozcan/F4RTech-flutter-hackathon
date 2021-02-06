import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';

class Donation {
  DocumentReference reference;
  double _amount; //Turkish Liras
  DateTime _dateDonation;
  String _donorID; //String or id or User class
  Student _donorRecipientID; //??

  Donation.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _amount = parsedMap['amount'],
        _dateDonation = (parsedMap['datedonation'] as Timestamp).toDate(),
        _donorID = parsedMap['donorid'],
        _donorRecipientID = parsedMap['donorrecipientid'];

  Map<String, dynamic> toMap() {
    return {
      'amount': _amount,
      'datedonation': _dateDonation,
      'donorid': _donorID,
      'donorrecipientid': _donorRecipientID,

    };
  }
  Donation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Student get donorRecipientID => _donorRecipientID;

  set donorRecipientID(Student value) {
    _donorRecipientID = value;
  }

  String get donorID => _donorID;

  set donorID(String value) {
    _donorID = value;
  }

  DateTime get dateDonation => _dateDonation;

  set dateDonation(DateTime value) {
    _dateDonation = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }
}
