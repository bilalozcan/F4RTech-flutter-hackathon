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
  List<String> _listOfPost;
  int _numberOfDonationsMade;
  double _donationAmount;
  int _level;
  double _point;

  User({@required id, @required email}) {
    _uid = id;
    _email = email;

  }

  User.Info(
      {@required id,
      @required email,
      @required username,
      @required fullname,
      @required telephone}) {
    _uid = id;
    _email = email;
    _username = username;
    _fullname = fullname;
    _telephone = telephone;
  }

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
        _addedStudentList = parsedMap['addedstudentslist'],
        _listOfDonationsMade = parsedMap['listofdonationsmade'],
        _numberOfDonationsMade = parsedMap['numberofdonationsmade'],
        _donationAmount = parsedMap['donationamount'],
        _level = parsedMap['level'],
        _point = parsedMap['point'],
        _listOfPost = parsedMap['listOfPost'];

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
      'addedstudentlist': _addedStudentList,
      'listofdonationsmade': _listOfDonationsMade,
      'numberofdonationsmade': _numberOfDonationsMade,
      'donationamount': _donationAmount,
      'level': _level,
      'point': _point,
      'listOfPost' : _listOfPost,

    };
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  double get point => _point;

  set point(double value) {
    _point = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  double get donationAmount => _donationAmount;

  set donationAmount(double value) {
    _donationAmount = value;
  }

  int get numberOfDonationsMade => _numberOfDonationsMade;

  set numberOfDonationsMade(int value) {
    _numberOfDonationsMade = value;
  }

  List<String> get listOfDonationsMade => _listOfDonationsMade;

  set listOfDonationsMade(List<String> value) {
    _listOfDonationsMade = value;
  }

  List<String> get addedStudentList => _addedStudentList;

  set addedStudentList(List<String> value) {
    _addedStudentList = value;
  }

  DateTime get lastTransactionDate => _lastTransactionDate;

  set lastTransactionDate(DateTime value) {
    _lastTransactionDate = value;
  }

  DateTime get dateOfRegistration => _dateOfRegistration;

  set dateOfRegistration(DateTime value) {
    _dateOfRegistration = value;
  }

  String get numberOfStudentsAdded => _numberOfStudentsAdded;

  set numberOfStudentsAdded(String value) {
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

  List<String> get listOfPost => _listOfPost;

  set listOfPost(List<String> value) {
    _listOfPost = value;
  }
}
