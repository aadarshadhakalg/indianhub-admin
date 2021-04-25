import 'package:admin/controller/transaction/transaction_controller.dart';
import 'package:admin/models/transaction_model.dart';
import 'package:admin/services/firestore_helper.dart';
import 'package:admin/views/screens/transactions/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovedRequests extends StatelessWidget {
  final FirestoreHelper _firestoreHelper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    return GetX(builder: (TransactionController controller) {
      return Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5.0,right: 5.0,top: 8.0),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: controller.currentRequestType.value ==
                              RequestType.LoadRequest
                          ? Colors.grey[300]
                          : Colors.transparent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.currentRequestType.value =
                            RequestType.LoadRequest;
                      },
                      child: Text(
                        'Load Requests',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0,right: 5.0,top: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: controller.currentRequestType.value ==
                              RequestType.WithdrawRequest
                          ? Colors.grey[300]
                          : Colors.transparent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.currentRequestType.value =
                            RequestType.WithdrawRequest;
                      },
                      child: Text('Withdraw Requests'),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: _firestoreHelper.getFilteredTransactions(
                    type: controller.currentRequestType.value ==
                            RequestType.LoadRequest
                        ? 'load'
                        : 'withdraw',
                    status: 'approved'),
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
                              backgroundColor: snapshot.data?[index].status ==
                                      'pending'
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
                            title:
                                Text('Amount: ${snapshot.data?[index].amount}'),
                            subtitle: Text(
                                '${snapshot.data?[index].type.toUpperCase()}'),
                            onTap: () {
                              Get.to(TransactionDetail(
                                  model: snapshot.data![index]));
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
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
