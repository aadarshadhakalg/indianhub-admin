import 'package:admin/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class NotifyScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send Notification".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: .3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: RequiredValidator(errorText: "Required *"),
                        controller: _titleController,
                        // maxLines: 2,
                        decoration: InputDecoration(
                          hintText: "Enter Notification Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: RequiredValidator(errorText: "Required *"),
                        controller: _messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          // labelText: "Message",
                          hintText: "Enter Notification Body",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Priority",
                              style: TextStyle(
                                fontSize: 16.0,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButton(
                                isDense: true,
                                underline: Text(""),
                                value: _notificationController.priority.value,
                                items: _notificationController.priorityList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  _notificationController.setPriority(value?.toString() ?? 'Normal');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _notificationController.notificationState.value ==
                              NotificationState.NormalState
                          ? RaisedButton.icon(
                              color: Colors.cyan,
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _notificationController.sendNotification(
                                    _titleController.text,
                                    _messageController.text,
                                    false,
                                  );
                                  _titleController.clear();
                                  _messageController.clear();
                                }
                              },
                              label: Text(
                                "Send Notification",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
