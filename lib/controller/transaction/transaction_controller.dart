import 'package:admin/models/transaction_model.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/services/firestore_helper.dart';
import 'package:admin/views/screens/transactions/transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RequestType { LoadRequest, WithdrawRequest }

enum TransactionControllerStates { Loading, Normal }

class TransactionController extends GetxController {
  Rx<TransactionControllerStates> currentState =
      Rx<TransactionControllerStates>(TransactionControllerStates.Normal);
  TextEditingController rejectResponseMessage = TextEditingController();
  TextEditingController approvedResponseMessage = TextEditingController();
  TextEditingController withdrawlTransactionId = TextEditingController();
  TextEditingController withdrawlTransactionTime = TextEditingController();
  Rx<RequestType> currentRequestType = Rx<RequestType>(RequestType.LoadRequest);
  FirestoreHelper _firestoreHelper = FirestoreHelper();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transaction');
  var totalTransactions = 0.obs;

  void totalTransaction() async {
    try {
      var alltransactions =
          await transactions.get().then((value) => value.docs);

      totalTransactions.value = alltransactions.length;
    } catch (e) {}
  }

  Future<void> rejectTransaction(TransactionModel model) async {
    currentState.value = TransactionControllerStates.Loading;
    Map data = model.toJson();
    data['status'] = 'rejected';
    data['response'] = rejectResponseMessage.text;

    TransactionModel newModel = TransactionModel.fromMap(data);

    try {
      await _firestoreHelper.updateTransaction(newModel);
      Get.offAll(Transactions());
      Get.rawSnackbar(title: 'Rejected!', message: 'Request Rejected');
    } catch (e) {
      Get.rawSnackbar(title: 'Error!', message: 'Error while Rejecting');
    }

    rejectResponseMessage.text = '';
    currentState.value = TransactionControllerStates.Normal;
  }

  approveLoadTransaction(TransactionModel model) async {
    currentState.value = TransactionControllerStates.Loading;
    Map transactionData = model.toJson();
    transactionData['status'] = 'approved';
    transactionData['response'] = approvedResponseMessage.text;
    TransactionModel newModel = TransactionModel.fromMap(transactionData);

    UserModel userModel = await _firestoreHelper.getUserDetail(model.uid);
    Map userData = userModel.toJson();
    userData['points'] = userData['points'] + model.amount;
    UserModel newUserModel = UserModel.fromMap(userData);

    try {
      await _firestoreHelper.updateTransaction(newModel);
      await _firestoreHelper.updateUser(newUserModel);
      Get.offAll(Transactions());
      Get.rawSnackbar(title: 'Rejected!', message: 'Request Rejected');
    } catch (e) {
      Get.rawSnackbar(title: 'Error!', message: 'Error while Approving');
    }
    approvedResponseMessage.text = '';
    currentState.value = TransactionControllerStates.Normal;
  }

  approveWithdrawTransaction(TransactionModel model) async {
    currentState.value = TransactionControllerStates.Loading;
    currentState.value = TransactionControllerStates.Loading;
    Map transactionData = model.toJson();
    transactionData['status'] = 'approved';
    transactionData['response'] = approvedResponseMessage.text;
    transactionData['transactionId'] = withdrawlTransactionId.text;
    transactionData['transactionTime'] = withdrawlTransactionTime.text;
    TransactionModel newModel = TransactionModel.fromMap(transactionData);

    UserModel userModel = await _firestoreHelper.getUserDetail(model.uid);
    Map userData = userModel.toJson();
    userData['points'] = userData['points'] - model.amount;
    UserModel newUserModel = UserModel.fromMap(userData);

    try {
      await _firestoreHelper.updateTransaction(newModel);
      await _firestoreHelper.updateUser(newUserModel);
      Get.offAll(Transactions());
      Get.rawSnackbar(title: 'Rejected!', message: 'Request Rejected');
    } catch (e) {
      Get.rawSnackbar(title: 'Error!', message: 'Error while Approving');
    }

    approvedResponseMessage.text = '';
    withdrawlTransactionTime.text = '';
    withdrawlTransactionId.text = '';
    currentState.value = TransactionControllerStates.Normal;
  }
}
