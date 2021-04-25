import 'package:admin/models/transaction_model.dart';
import 'package:admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> updateUser(UserModel model)async{
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


  Future<void> updateTransaction(TransactionModel model)async{
    await _db.collection('transactions').doc(model.id).update(model.toJson());
  }
}
