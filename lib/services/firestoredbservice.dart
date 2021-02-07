import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/Comment.dart';
import 'package:education/models/Donation.dart';
import 'package:education/models/Student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:education/models/User.dart' as usr;

class FirestoreDBService {
  final _instance = FirebaseFirestore.instance;

  Future<dynamic> getUsers() async {
    var list = [];
    var collectionReference = await _instance.collection('Users');
    var querySnapshot =
        await collectionReference.orderBy('point', descending: true).get();

    print(querySnapshot.docs.toString());
    for (var i = 0; i < querySnapshot.docs.length; ++i) {
      var map = {};
      map['point'] = querySnapshot.docs[i].data()['point'];
      map['fullname'] = querySnapshot.docs[i].data()['fullname'];
      map['level'] = querySnapshot.docs[i].data()['level'];
      list.add(map);
    }
    return list;
  }

  Future<dynamic> getAllUsersUsername() async {
    var list = [];
    var collectionReference = await _instance.collection('Users');
    var querySnapshot = await collectionReference.get();
    for (var i = 0; i < querySnapshot.docs.length; ++i) {
      list.add(querySnapshot.docs[i].data()['username']);
    }
    return list;
  }

  Future<dynamic> getCurrentUser() async {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var _user;
    try {
      var result = await _instance.collection('Users').doc('${user.uid}').get();
      if (result != null) {
        _user = usr.User.fromSnapshot(result);
      }
      return _user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getUser(String uid) async {
    var _user;
    try {
      var result = await _instance.collection('Users').doc(uid).get();
      if (result != null) {
        _user = usr.User.fromSnapshot(result);
      }
      return _user;
    } catch (e) {
      print('A' + e);
      return e;
    }
  }

  Future<dynamic> getStudent(userID) async {
    var _instance = FirebaseFirestore.instance;
    var _student;
    try {
      var result =
          await _instance.collection('Students').doc('${userID}').get();
      if (result != null) {
        _student = Student.fromSnapshot(result);
        return _student;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> getDonations(donationID) async {
    var _donation;
    try {
      var result = await FirebaseFirestore.instance
          .collection('Donations')
          .doc('$donationID')
          .get();
      if (result != null) {
        _donation = Donation.fromSnapshot(result);
        return _donation;
      }
    } catch (e) {
      print('getDonations Erro $e');
      return e;
    }
  }

  Future<dynamic> postComment(Comment comment, Student student) async {
    var shareName = DateTime.now().microsecondsSinceEpoch.toString();
    student.listOfComments.add(shareName);
    try {
      var result = await FirebaseFirestore.instance
          .collection('Comments')
          .doc(shareName)
          .set(comment.toMap());
      var result2 = await student.reference.update({
        'listofcomments': student.listOfComments,
      });
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> addLikeorDislikeStudent(
      Student student, usr.User user) async {
    if (!student.listOfLikes.contains(user.uid)) {
      student.listOfLikes.add(user.uid);
      student.likeCount += 1;
    } else {
      student.listOfLikes.remove(user.uid);
      student.likeCount -= 1;
    }
    try {
      await student.reference.update({
        'listoflikes': student.listOfLikes,
        'likecount': student.likeCount,
      });
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> addLikeorDislikeUser(Student student, usr.User user) async {
    if (!user.likeList.contains(student.uid)) {
      user.likeList.add(student.uid);
    } else {
      user.likeList.remove(student.uid);
    }
    try {
      await user.reference.update({
        'likeList': user.likeList,
      });
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> addDonation(
      Donation donation, usr.User donor, Student student, donationName) async {
    donor.lastTransactionDate = DateTime.now();
    donor.listOfDonationsMade.add(donationName);
    donor.donationAmount += donation.amount;
    donor.numberOfDonationsMade += 1;
    donor.point += donation.amount;

    student.lastTransactionDate = DateTime.now();
    student.listOfDonations.add(donationName);
    student.donationCount += 1;
    student.donationAmountReceived += donation.amount;

    try {
      await FirebaseFirestore.instance
          .collection('Donations')
          .doc(donationName)
          .set(donation.toMap());
      await donor.reference.update({
        'lasttransactiondate': donor.lastTransactionDate,
        'listofdonationsmade': donor.listOfDonationsMade,
        'donationamount': donor.donationAmount,
        'numberofdonationsmade': donor.numberOfDonationsMade,
        'point': donor.point,
      });
      await student.reference.update({
        'lasttransactiondate': student.lastTransactionDate,
        'listofDonations': student.listOfDonations,
        'donationamountreceived': student.donationAmountReceived,
        'donationcount': student.donationCount,
      });
      return true;
    } catch (e) {
      print('ERR' + e);
      return e;
    }
  }
}
