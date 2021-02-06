import 'package:cloud_firestore/cloud_firestore.dart';

class Institution {
  DocumentReference reference;
  String _name;
  String _websiteUrl;
  String _numberOfStudentsIntheInstitution;
  String _contact;
  String _adress;

  Institution.fromMap(Map<String, dynamic> parsedMap, {this.reference})
      : _name = parsedMap['name'],
        _websiteUrl = parsedMap['websiteurl'],
        _numberOfStudentsIntheInstitution =
            parsedMap['numberofstudentsintheinstitution'],
        _contact = parsedMap['contact'],
        _adress = parsedMap['adress'];

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'websiteurl': _websiteUrl,
      'numberofstudentsintheinstitution': _numberOfStudentsIntheInstitution,
      'contact': _contact,
      'adress': _adress,
    };
  }

  Institution.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  String get adress => _adress;

  set adress(String value) {
    _adress = value;
  }

  String get contact => _contact;

  set contact(String value) {
    _contact = value;
  }

  String get numberOfStudentsIntheInstitution =>
      _numberOfStudentsIntheInstitution;

  set numberOfStudentsIntheInstitution(String value) {
    _numberOfStudentsIntheInstitution = value;
  }

  String get websiteUrl => _websiteUrl;

  set websiteUrl(String value) {
    _websiteUrl = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
