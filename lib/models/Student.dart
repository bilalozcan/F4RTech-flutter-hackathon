import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Institution.dart';

class Student {
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

  Student.fromMap(Map<String, dynamic> parsedMap)
      : _userID = parsedMap["id"],
        _dateOfRegistration =
            (parsedMap["dateofregistration"] as Timestamp).toDate(),
        _lastTransactionDate =
            (parsedMap["lasttransactiondate"] as Timestamp).toDate(),
        _fullname = parsedMap["fullname"],
        _telephone = parsedMap["telephone"],
        _identificationNumber = parsedMap["identificationnumber"],
        _age = parsedMap["age"],
        _adress = parsedMap["adress"],
        _picturesOfStudent = parsedMap["picturesofstudent"],
        _approvalStatus = parsedMap["approvalstatus"],
        _affiliatedInstitution = parsedMap["affiliatedInstitution"],
        _donationsReceived = parsedMap["donationsReceived"],
        _donationAmountReceived = parsedMap["donationAmountReceived"],
        _listOfDonations = parsedMap["listofdonations"],
        _classOfStudent = parsedMap["classofstudent"],
        _explanation = parsedMap["explanation"],
        _listOfComments = parsedMap["listofcomments"];

  Map<String, dynamic> toMap() {
    return {
      "id": _userID,
      "fullname": _fullname,
      "dateofregistration": _dateOfRegistration,
      "lasttransactiondate": _lastTransactionDate,
      "telephone": _telephone,
      "identificationnumber": _identificationNumber,
      "age": _age,
      "adress": _adress,
      "picturesofstudent": _picturesOfStudent,
      "approvalstatus": _approvalStatus,
      "affiliatedInstitution": _affiliatedInstitution,
      "donationsreceived": _donationsReceived,
      "donationamountreceived": _donationAmountReceived,
      "listofDonations": _listOfDonations,
      "classofstudent": _classOfStudent,
      "explanation": _explanation,
      "listofcomments": _listOfComments,
    };
  }
}
