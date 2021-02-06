import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Institution.dart';

class Student {
  DocumentReference reference;
  String _userID; //Kayıt eden kullanıcını id si
  DateTime _dateOfRegistration;
  DateTime _lastTransactionDate;
  String _fullname;
  String _telephone;
  String _identificationNumber;
  int _age;
  String _adress;
  List<String> _picturesOfStudent;
  bool _approvalStatus;
  Institution _affiliatedInstitution;
  int _donationsReceived;
  double _donationAmountReceived;
  List<String> _listOfDonations;
  int _classOfStudent;
  String _explanation;
  List<String> _listOfComments;

  Student.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _userID = parsedMap['id'],
        _dateOfRegistration =
            (parsedMap['dateofregistration'] as Timestamp).toDate(),
        _lastTransactionDate =
            (parsedMap['lasttransactiondate'] as Timestamp).toDate(),
        _fullname = parsedMap['fullname'],
        _telephone = parsedMap['telephone'],
        _identificationNumber = parsedMap['identificationnumber'],
        _age = parsedMap['age'],
        _adress = parsedMap['adress'],
        _picturesOfStudent = parsedMap['picturesofstudent'],
        _approvalStatus = parsedMap['approvalstatus'],
        _affiliatedInstitution = parsedMap['affiliatedInstitution'],
        _donationsReceived = parsedMap['donationsReceived'],
        _donationAmountReceived = parsedMap['donationAmountReceived'],
        _listOfDonations = parsedMap['listofdonations'],
        _classOfStudent = parsedMap['classofstudent'],
        _explanation = parsedMap['explanation'],
        _listOfComments = parsedMap['listofcomments'];

  Map<String, dynamic> toMap() {
    return {
      'id': _userID,
      'fullname': _fullname,
      'dateofregistration': _dateOfRegistration,
      'lasttransactiondate': _lastTransactionDate,
      'telephone': _telephone,
      'identificationnumber': _identificationNumber,
      'age': _age,
      'adress': _adress,
      'picturesofstudent': _picturesOfStudent,
      'approvalstatus': _approvalStatus,
      'affiliatedInstitution': _affiliatedInstitution,
      'donationsreceived': _donationsReceived,
      'donationamountreceived': _donationAmountReceived,
      'listofDonations': _listOfDonations,
      'classofstudent': _classOfStudent,
      'explanation': _explanation,
      'listofcomments': _listOfComments,
    };
  }
  Student.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  List<String> get listOfComments => _listOfComments;

  set listOfComments(List<String> value) {
    _listOfComments = value;
  }

  String get explanation => _explanation;

  set explanation(String value) {
    _explanation = value;
  }

  int get classOfStudent => _classOfStudent;

  set classOfStudent(int value) {
    _classOfStudent = value;
  }

  List<String> get listOfDonations => _listOfDonations;

  set listOfDonations(List<String> value) {
    _listOfDonations = value;
  }

  double get donationAmountReceived => _donationAmountReceived;

  set donationAmountReceived(double value) {
    _donationAmountReceived = value;
  }

  int get donationsReceived => _donationsReceived;

  set donationsReceived(int value) {
    _donationsReceived = value;
  }

  Institution get affiliatedInstitution => _affiliatedInstitution;

  set affiliatedInstitution(Institution value) {
    _affiliatedInstitution = value;
  }

  bool get approvalStatus => _approvalStatus;

  set approvalStatus(bool value) {
    _approvalStatus = value;
  }

  List<String> get picturesOfStudent => _picturesOfStudent;

  set picturesOfStudent(List<String> value) {
    _picturesOfStudent = value;
  }

  String get adress => _adress;

  set adress(String value) {
    _adress = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get identificationNumber => _identificationNumber;

  set identificationNumber(String value) {
    _identificationNumber = value;
  }

  String get telephone => _telephone;

  set telephone(String value) {
    _telephone = value;
  }

  String get fullname => _fullname;

  set fullname(String value) {
    _fullname = value;
  }

  DateTime get lastTransactionDate => _lastTransactionDate;

  set lastTransactionDate(DateTime value) {
    _lastTransactionDate = value;
  }

  DateTime get dateOfRegistration => _dateOfRegistration;

  set dateOfRegistration(DateTime value) {
    _dateOfRegistration = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }
}
