import 'package:admin/controller/transaction/transaction_controller.dart';
import 'package:admin/models/transaction_model.dart';
import 'package:admin/services/validator.dart';
import 'package:admin/views/components/form_input_field_with_icon.dart';
import 'package:admin/views/components/form_verticle_spacer.dart';
import 'package:admin/views/screens/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetail extends StatelessWidget {
  final TransactionModel model;

  TransactionDetail({Key? key, required this.model}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Get.to(
                UserDetail(id: model.uid),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id: ${model.id}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Requested Date: ${model.date}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Transaction Type: ${model.type.toUpperCase()}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Amount: ${model.amount}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Transaction Medium: ${model.transactionMedium}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Status: ${model.status.toUpperCase()}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Transaction id: ${model.transactionId}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Transaction Time: ${model.transactionTime}',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            Text(
              'Response: ${model.response}',
              style: TextStyle(fontSize: 16.0),
            ),
            Expanded(child: Container()),
            Visibility(
              visible: model.status == 'pending',
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Builder(builder: (context) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith(
                              (states) => const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.red)),
                        onPressed: () {
                          showBottomSheet(
                            elevation: 20.0,
                            context: context,
                            builder: (BuildContext context) {
                              return GetX(
                                  builder: (TransactionController controller) {
                                print(controller.currentState.value);
                                if (controller.currentState.value ==
                                    TransactionControllerStates.Normal) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          FormVerticalSpace(),
                                          FormInputFieldWithIcon(
                                            controller: controller
                                                .rejectResponseMessage,
                                            iconPrefix: Icons.message,
                                            labelText: 'Your Response',
                                            validator: Validator().notEmpty,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller
                                                .rejectResponseMessage
                                                .text = value ?? 'Not Provided',
                                            maxLines: 3,
                                            minLines: 3,
                                          ),
                                          FormVerticalSpace(),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await controller
                                                    .rejectTransaction(model);
                                              },
                                              child: Text('Reject'))
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                            },
                          );
                        },
                        child: Text(
                          'Reject',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      );
                    }),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith(
                              (states) => const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green)),
                        onPressed: () {
                          showBottomSheet(
                            elevation: 20.0,
                            context: context,
                            builder: (BuildContext context) {
                              return GetX(
                                  builder: (TransactionController controller) {
                                print(controller.currentState.value);
                                if (controller.currentState.value ==
                                    TransactionControllerStates.Normal) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          model.type == 'withdraw'
                                              ? FormVerticalSpace()
                                              : Container(),
                                          model.type == 'withdraw'
                                              ? FormInputFieldWithIcon(
                                                  controller: controller
                                                      .withdrawlTransactionId,
                                                  iconPrefix: Icons.credit_card,
                                                  labelText: 'Transaction ID',
                                                  validator:
                                                      Validator().notEmpty,
                                                  onChanged: (value) => null,
                                                  onSaved: (value) => controller
                                                          .rejectResponseMessage
                                                          .text =
                                                      value ?? 'Not Provided',
                                                  maxLines: 1,
                                                )
                                              : Container(),
                                          model.type == 'withdraw'
                                              ? FormVerticalSpace()
                                              : Container(),
                                          model.type == 'withdraw'
                                              ? FormInputFieldWithIcon(
                                                  controller: controller
                                                      .withdrawlTransactionTime,
                                                  iconPrefix: Icons.watch,
                                                  labelText: 'Transaction Time',
                                                  validator:
                                                      Validator().notEmpty,
                                                  onChanged: (value) => null,
                                                  onSaved: (value) => controller
                                                          .rejectResponseMessage
                                                          .text =
                                                      value ?? 'Not Provided',
                                                  maxLines: 1,
                                                )
                                              : Container(),
                                          FormVerticalSpace(),
                                          FormInputFieldWithIcon(
                                            controller: controller
                                                .approvedResponseMessage,
                                            iconPrefix: Icons.message,
                                            labelText: 'Your Response',
                                            validator: Validator().none,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller
                                                .approvedResponseMessage
                                                .text = value ?? 'Not Provided',
                                            maxLines: 3,
                                            minLines: 3,
                                          ),
                                          FormVerticalSpace(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (model.type == 'load') {
                                                await controller
                                                    .approveLoadTransaction(
                                                        model);
                                              } else {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await controller
                                                      .approveWithdrawTransaction(
                                                          model);
                                                }
                                              }
                                            },
                                            child: Text('Approve'),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                            },
                          );
                        },
                        child: Text(
                          'Approve',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
