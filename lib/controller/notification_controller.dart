import 'package:admin/config/fcm.dart';
import 'package:admin/models/message_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

enum NotificationState {
  SendingState,
  NormalState,
}

class NotificationController extends GetxController {
  List priorityList = ["Normal", "High"];
  List receiverList = ["All", "Paid", "Unpaid"];

  Rx<String> priority = Rx<String>("Normal");
  Rx<String> receiver = Rx<String>("All");
  var notificationState = NotificationState.NormalState.obs;

  void setPriority(String value) {
    priority.value = value;
  }

  void setReceiver(String value) {
    receiver.value = value;
  }

  Future<void> sendNotification(
      String title, String body, bool isNotice) async {
    d.Dio dio = d.Dio();
    notificationState.value = NotificationState.SendingState;

    try {
      d.Response response = await dio.post(
        FCM.endPoint,
        data: messageModelToJson(
          MessageModel(
            notification: Notification(
              body: body,
              title: title,
            ),
            priority: priority.value.toLowerCase(),
            data: Data(
              clickaction: "FLUTTERNOTIFICATIONCLICK",
              id: "1",
              status: "done",
              notices: isNotice,
            ),
            to: "/topics/${receiver.value.toLowerCase()}",
          ),
        ),
        options: d.Options(
          headers: {"Authorization": "key=${FCM.key}"},
        ),
      );

      if (response.statusCode == 200) {
        Get.rawSnackbar(
          title: "Success",
          message: "Notification sent successfully.",
        );
        notificationState.value = NotificationState.NormalState;
      } else {
        Get.rawSnackbar(
          title: "Error",
          message: "Notification not sent.",
        );
        notificationState.value = NotificationState.NormalState;
      }
    } catch (e) {
      Get.rawSnackbar(
        title: "Error",
        message: "Notification not sent.",
      );
      notificationState.value = NotificationState.NormalState;
    }
  }
}
