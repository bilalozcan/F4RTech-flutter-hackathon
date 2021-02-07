import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Student.dart';

class Donation {
  DocumentReference reference;
  String _uid;
  int _amount; //Turkish Liras
  DateTime _dateDonation;
  String _donorID; //User
  String _donorRecipientID;

  Donation(this._uid, this._amount, this._dateDonation, this._donorID,
      this._donorRecipientID); //Student


  Donation.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _amount = parsedMap['amount'],
        _uid = parsedMap['uid'],
        _dateDonation = (parsedMap['datedonation'] as Timestamp).toDate(),
        _donorID = parsedMap['donorid'],
        _donorRecipientID = parsedMap['donorrecipientid'];

  Map<String, dynamic> toMap() {
    return {
      'amount': _amount,
      'uid' : _uid,
      'datedonation': _dateDonation,
      'donorid': _donorID,
      'donorrecipientid': _donorRecipientID,

    };
  }
  Donation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get donorRecipientID => _donorRecipientID;

  set donorRecipientID(String value) {
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

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }
}
