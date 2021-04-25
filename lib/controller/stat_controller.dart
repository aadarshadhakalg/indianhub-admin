import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference stats =
      FirebaseFirestore.instance.collection('stats').doc('allstats');
  var totalUsers = 0.obs;
  var paidUsers = 0.obs;
  var freeUsers = 0.obs;
  var totalTransactions = 0.obs;

  Future<void> getStats() async {
    try {
      var stat = await stats.get().then((element) => element.data());

      totalUsers.value = stat?["totalUsers"];
      paidUsers.value = stat?["paidUsers"];
      freeUsers.value = stat?["unpaidUsers"];
      totalTransactions.value = stat?["transactions"];
    } catch (e) {
      return null;
    }
  }
}
