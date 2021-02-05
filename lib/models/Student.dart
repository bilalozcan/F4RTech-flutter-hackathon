import 'package:education/models/Comment.dart';
import 'package:education/models/Donation.dart';
import 'package:education/models/Institution.dart';
import 'package:education/models/User.dart';

class Student {
  User _user;
  DateTime _dateOfRegistration;
  DateTime _lastTransactionDate;
  String _fullname;
  String _email;
  String _telephone;
  String _identificationNumber;
  int _age;
  String _adress;
  List<String> _picturesOfStudent;
  bool _approvalStatus;
  Institution _affiliatedInstitution;
  int _donationsReceived;
  double _donationAmountReceived;
  List<Donation> _listOfDonations;
  int _classOfStudent;
  String _explanation;
  List<Comment> _listOfComments;
}
