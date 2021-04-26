import 'dart:io';

import 'package:admin/models/team_model.dart';
import 'package:admin/models/transaction_model.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/services/cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  /// USer Helpers Functions
  ///
  ///
  ///
  ///
  ///

  Future<List<UserModel>> getAllUsers(String uid) async {
    QuerySnapshot querySnapshot = await _db.collection('users').get();

    List<UserModel> allUsers = [];

    for (var snapshots in querySnapshot.docs) {
      Map data = snapshots.data();
      UserModel model = UserModel.fromMap(data);
      allUsers.add(model);
    }
    return allUsers;
  }

  Future<List<UserModel>> searchUsers(String query) async {
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    List<UserModel> allUsers = [];

    for (var snapshots in querySnapshot.docs) {
      Map data = snapshots.data();
      UserModel model = UserModel.fromMap(data);
      allUsers.add(model);
    }
    return allUsers;
  }

  Future<UserModel> getUserDetail(String id) async {
    DocumentSnapshot snapshot = await _db.collection('users').doc(id).get();
    UserModel userModel = UserModel.fromMap(snapshot.data()!);
    return userModel;
  }

  Future<void> updateUser(UserModel model) async {
    await _db.collection('users').doc(model.uid).update(model.toJson());
  }

  /// Transactions Helper Functions
  ///
  ///
  ///
  ///

  getAllTransactions() {}

  Future<void> addTransaction({
    required String type,
    required int amount,
    required String uid,
    required String transactionMedium,
    String? transactionId,
    String? transactionTime,
    required DateTime date,
  }) async {
    await _db.collection('transactions').add({
      'type': type,
      'amount': amount,
      'uid': uid,
      'status': 'pending',
      'response': null,
      'transactionMedium': transactionMedium,
      'transactionId': transactionId,
      'transactionTime': transactionTime,
      'date': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<TransactionModel>> getMyTransactions(String uid) async {
    QuerySnapshot querySnapshot = await _db
        .collection('transactions')
        .where('uid', isEqualTo: uid)
        .orderBy('date', descending: true)
        .get();

    List<TransactionModel> allTransactions = [];

    for (var snapshots in querySnapshot.docs) {
      Map data = snapshots.data();
      data['id'] = snapshots.id;
      TransactionModel model = TransactionModel.fromMap(data);
      allTransactions.add(model);
    }
    return allTransactions;
  }

  Future<List<TransactionModel>> getFilteredTransactions(
      {required String type, required String status}) async {
    QuerySnapshot querySnapshot = await _db
        .collection('transactions')
        .where('status', isEqualTo: status)
        .where('type', isEqualTo: type)
        .orderBy('date', descending: true)
        .get();

    List<TransactionModel> allTransactions = [];

    for (var snapshots in querySnapshot.docs) {
      Map data = snapshots.data();
      data['id'] = snapshots.id;
      print(data);
      TransactionModel model = TransactionModel.fromMap(data);
      print(data);

      allTransactions.add(model);
    }
    return allTransactions;
  }

  Future<void> updateTransaction(TransactionModel model) async {
    await _db.collection('transactions').doc(model.id).update(model.toJson());
  }

  ///Referral Helper
  ///
  ///
  Future<void> updateBonus(String referralCode, String forUser) async {
    QuerySnapshot referralcodes = await _db
        .collection('referralcodes')
        .where('code', isEqualTo: referralCode)
        .get();
    String documentid = referralcodes.docs[0].id;
    DocumentSnapshot referralCodeSnapshot =
        await _db.collection('referralcodes').doc(documentid).get();
    Map<String, dynamic> referralData = referralCodeSnapshot.data()!;
    List waitingForBonusList = referralData['waitingForBonus'];

    if (waitingForBonusList.contains(forUser)) {
      waitingForBonusList.remove(forUser);
      referralData['bonusEarned'] = referralData['bonusEarned'] + 1;

      referralData['waitingForBonus'] = waitingForBonusList;

      _db.collection('referralcodes').doc(documentid).update(referralData);
    }
  }

  ///Teams Helper
  ///
  ///

  Future<List<TeamModel>> getAllTeams() async {
    QuerySnapshot teamsSnapshot = await _db.collection('teams').get();
    return teamsSnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data();
      data.addAll(
        {
          'id': e.id,
        },
      );
      return TeamModel.fromMap(data);
    }).toList();
  }

  Future<void> addTeam(
      {required String teamName, required File teamImage}) async {
    TaskSnapshot? snapshot =
        await CloudStorageService.instance.uploadTeamImage(teamImage);

    await _db.collection('teams').add({
      'teamName': teamName,
      'teamImage': await snapshot!.ref.getDownloadURL(),
    });
  }
}
