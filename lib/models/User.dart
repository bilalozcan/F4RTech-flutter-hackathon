import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  DocumentReference reference;
  String _fullname;
  String _telephone;
  String _email;
  String _username;
  String _uid;
  String _numberOfStudentsAdded;

  DateTime _dateOfRegistration;
  DateTime _lastTransactionDate;

  List<String> _addedStudentList; //Student or String List
  List<String> _listOfDonationsMade;

  int _numberOfDonationsMade;
  double _donationAmount;
  int _level;
  double _point;

  User({@required id, @required email}) {
    this._uid = id;
    this._email = email;
  }

  User.Info(
      {@required id,
      @required email,
      @required username,
      @required fullname,
      @required telephone}) {
    this._uid = id;
    this._email = email;
    this._username = username;
    this._fullname = fullname;
    this._telephone = telephone;
  }

  User.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _uid = parsedMap["id"],
        _fullname = parsedMap["fullname"],
        _telephone = parsedMap["telephone"],
        _email = parsedMap["email"],
        _username = parsedMap["username"],
        _numberOfStudentsAdded = parsedMap["numberofstudentsadded"],
        _dateOfRegistration =
            (parsedMap["dateofregistration"] as Timestamp).toDate(),
        _lastTransactionDate =
            (parsedMap["lasttransactiondate"] as Timestamp).toDate(),
        _addedStudentList = parsedMap["addedstudentslist"],
        _listOfDonationsMade = parsedMap["listofdonationsmade"],
        _numberOfDonationsMade = parsedMap["numberofdonationsmade"],
        _donationAmount = parsedMap["donationamount"],
        _level = parsedMap["level"],
        _point = parsedMap["point"];

  Map<String, dynamic> toMap() {
    return {
      "id": _uid,
      "fullname": _fullname,
      "telephone": _telephone,
      "email": _email,
      "username": _username,
      "numberofstudentsadded": _numberOfStudentsAdded,
      "dateofregistration": _dateOfRegistration,
      "lasttransactiondate": _lastTransactionDate,
      "addedstudentlist": _addedStudentList,
      "listofdonationsmade": _listOfDonationsMade,
      "numberofdonationsmade": _numberOfDonationsMade,
      "donationamount": _donationAmount,
      "level": _level,
      "point": _point
    };
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
