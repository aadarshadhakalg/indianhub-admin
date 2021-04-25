import 'package:admin/models/transaction_model.dart';
import 'package:admin/services/firestore_helper.dart';
import 'package:admin/views/screens/transactions/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersTransaction extends StatelessWidget {
  final String uid;

  UsersTransaction({required this.uid});

  final FirestoreHelper _firestoreHelper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Transactions'),
      ),
      body: FutureBuilder(
          future: _firestoreHelper
              .getMyTransactions(uid),
          builder: (BuildContext context,
              AsyncSnapshot<List<TransactionModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            snapshot.data?[index].status == 'pending'
                                ? Colors.amber
                                : snapshot.data?[index].status == 'approved'
                                    ? Colors.green
                                    : Colors.red,
                        child: Icon(
                          snapshot.data?[index].status == 'pending'
                              ? Icons.pending_actions
                              : snapshot.data?[index].status == 'approved'
                                  ? Icons.approval
                                  : Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      title: Text('Amount: ${snapshot.data?[index].amount}'),
                      subtitle:
                          Text('${snapshot.data?[index].type.toUpperCase()}'),
                      onTap: () {
                        Get.to(TransactionDetail(model: snapshot.data![index]));
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: Container(
                    height: 100.0,
                    child: Column(
                      children: [Text('No Transactions Found')],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
