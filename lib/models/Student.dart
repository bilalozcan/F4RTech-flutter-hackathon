import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Institution.dart';

class Student {
<<<<<<< Updated upstream
  final String _userID; //Kayıt eden kullanıcını id si
  final DateTime _dateOfRegistration;
  final DateTime _lastTransactionDate;
  final String _fullname;
  final String _telephone;
  final String _identificationNumber;
  final int _age;
  final String _adress;
  final List<String> _picturesOfStudent;
  final bool _approvalStatus;
  final Institution _affiliatedInstitution;
  final int _donationsReceived;
  final double _donationAmountReceived;
  final List<String> _listOfDonations;
  final int _classOfStudent;
  final String _explanation;
  final List<String> _listOfComments;

  Student.fromMap(Map<String, dynamic> parsedMap)
      : _userID = parsedMap['id'],
=======
  DocumentReference reference;
  String _publisher;
  DateTime _dateOfRegistration;
  DateTime _lastTransactionDate;
  String _fullname;
  String _telephone;
  String _tcID;
  int _age;
  String _address;
  List<String> _picturesOfStudent;
  bool _approvalStatus;
  String _affiliatedInstitution;
  List _donationsReceived;
  double _donationAmountReceived;
  List _listOfDonations;
  int _classOfStudent;
  String _explanation;
  List _listOfComments;

  Student(
      [this._publisher,
      this._dateOfRegistration,
      this._lastTransactionDate,
      this._fullname,
      this._telephone,
      this._tcID,
      this._age,
      this._address,
      this._picturesOfStudent,
      this._approvalStatus,
      this._affiliatedInstitution,
      this._donationsReceived,
      this._donationAmountReceived,
      this._listOfDonations,
      this._classOfStudent,
      this._explanation,
      this._listOfComments,
      this.reference]);

  Student.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _publisher = parsedMap['publisher'],
>>>>>>> Stashed changes
        _dateOfRegistration =
            (parsedMap['dateofregistration'] as Timestamp).toDate(),
        _lastTransactionDate =
            (parsedMap['lasttransactiondate'] as Timestamp).toDate(),
        _fullname = parsedMap['fullname'],
        _telephone = parsedMap['telephone'],
        _tcID = parsedMap['tcID'],
        _age = parsedMap['age'],
        _address = parsedMap['address'],
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
      'publisher': _publisher,
      'fullname': _fullname,
      'dateofregistration': _dateOfRegistration,
      'lasttransactiondate': _lastTransactionDate,
      'telephone': _telephone,
      'tcID': _tcID,
      'age': _age,
      'address': _address,
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
<<<<<<< Updated upstream
=======

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

  bool get approvalStatus => _approvalStatus;

  set approvalStatus(bool value) {
    _approvalStatus = value;
  }

  List<String> get picturesOfStudent => _picturesOfStudent;

  set picturesOfStudent(List<String> value) {
    _picturesOfStudent = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get tcID => _tcID;

  set tcID(String value) {
    _tcID = value;
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

  String get publisher => _publisher;

  set publisher(String value) {
    _publisher = value;
  }
>>>>>>> Stashed changes
}
