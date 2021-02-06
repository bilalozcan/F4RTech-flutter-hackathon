import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  DocumentReference reference;
  String _publisher; // postedTheComment
  String _student;
  String _content;
  DateTime _dateOfComment;

  Comment(this._publisher, this._student, this._content, this._dateOfComment);
  Comment.fromMap(Map<String, dynamic> parsedMap, {this.reference}):
        _publisher = parsedMap['publisher'],
        _student = parsedMap['student'],
        _content = parsedMap['content'],
        _dateOfComment = (parsedMap['dateOfComment'] as Timestamp).toDate();
  Map<String, dynamic> toMap() {
    return {
      'publisher': _publisher,
      'student': _student,
      'content': _content,
      'dateOfComment' : _dateOfComment,
    };
  }
  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get student => _student;

  set student(String value) {
    _student = value;
  }

  String get publisher => _publisher;

  set publisher(String value) {
    _publisher = value;
  }
}
