class Institution {
  final String _name;
  final String _websiteUrl;
  final String _numberOfStudentsIntheInstitution;
  final String _contact;
  final String _adress;

  Institution.fromMap(Map<String, dynamic> parsedMap)
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
}
