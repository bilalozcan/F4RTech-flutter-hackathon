import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  DocumentReference reference;
  String _fullname;
  String _telephone;
  String _email;
  String _username;
  String _uid;
  int _numberOfStudentsAdded;

  DateTime _dateOfRegistration;
  DateTime _lastTransactionDate;

  List _listOfDonationsMade;
  List _listOfPost;

  int _numberOfDonationsMade;
  int _donationAmount;
  int _level;
  int _point;
  List _likeList;

  User({@required id, @required email}) {
    _uid = id;
    _email = email;
  }

  User.Info(
      this._fullname,
      this._telephone,
      this._email,
      this._username,
      this._uid,
      this._numberOfStudentsAdded,
      this._dateOfRegistration,
      this._lastTransactionDate,
      this._listOfDonationsMade,
      this._listOfPost,
      this._numberOfDonationsMade,
      this._donationAmount,
      this._level,
      this._point,
      this._likeList);

  User.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _uid = parsedMap['id'],
        _fullname = parsedMap['fullname'],
        _telephone = parsedMap['telephone'],
        _email = parsedMap['email'],
        _username = parsedMap['username'],
        _numberOfStudentsAdded = parsedMap['numberofstudentsadded'],
        _dateOfRegistration =
            (parsedMap['dateofregistration'] as Timestamp).toDate(),
        _lastTransactionDate =
            (parsedMap['lasttransactiondate'] as Timestamp).toDate(),
        _listOfDonationsMade = parsedMap['listofdonationsmade'],
        _numberOfDonationsMade = parsedMap['numberofdonationsmade'],
        _donationAmount = parsedMap['donationamount'],
        _level = parsedMap['level'],
        _point = parsedMap['point'],
        _listOfPost = parsedMap['listOfPost'],
        _likeList = parsedMap['likeList'];

  Map<String, dynamic> toMap() {
    return {
      'id': _uid,
      'fullname': _fullname,
      'telephone': _telephone,
      'email': _email,
      'username': _username,
      'numberofstudentsadded': _numberOfStudentsAdded,
      'dateofregistration': _dateOfRegistration,
      'lasttransactiondate': _lastTransactionDate,
      'listofdonationsmade': _listOfDonationsMade,
      'numberofdonationsmade': _numberOfDonationsMade,
      'donationamount': _donationAmount,
      'level': _level,
      'point': _point,
      'listOfPost': _listOfPost,
      'likeList': _likeList,
    };
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  List get likeList => _likeList;

  set likeList(List value) {
    _likeList = value;
  }

  int get point => _point;

  set point(int value) {
    _point = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  int get donationAmount => _donationAmount;

  set donationAmount(int value) {
    _donationAmount = value;
  }

  int get numberOfDonationsMade => _numberOfDonationsMade;

  set numberOfDonationsMade(int value) {
    _numberOfDonationsMade = value;
  }

  List get listOfDonationsMade => _listOfDonationsMade;

  set listOfDonationsMade(List<String> value) {
    _listOfDonationsMade = value;
  }

  DateTime get lastTransactionDate => _lastTransactionDate;

  set lastTransactionDate(DateTime value) {
    _lastTransactionDate = value;
  }

  DateTime get dateOfRegistration => _dateOfRegistration;

  set dateOfRegistration(DateTime value) {
    _dateOfRegistration = value;
  }

  int get numberOfStudentsAdded => _numberOfStudentsAdded;

  set numberOfStudentsAdded(int value) {
    _numberOfStudentsAdded = value;
  }

  String get uid => _uid;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get telephone => _telephone;

  set telephone(String value) {
    _telephone = value;
  }

  String get fullname => _fullname;

  set fullname(String value) {
    _fullname = value;
  }

  List get listOfPost => _listOfPost;

  set listOfPost(List value) {
    _listOfPost = value;
  }

  @override
  String toString() {
    return 'User';
  }
}
