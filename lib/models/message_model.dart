import 'package:meta/meta.dart';
import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    required this.notification,
    required this.priority,
    required this.data,
    required this.to,
  });

  final Notification notification;
  final String priority;
  final Data data;
  final String to;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        notification: Notification.fromJson(json["notification"]),
        priority: json["priority"],
        data: Data.fromJson(json["data"]),
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "priority": priority,
        "data": data.toJson(),
        "to": to,
      };
}

class Data {
  Data({
    required this.clickaction,
    required this.id,
    required this.status,
    required this.notices,
  });

  final String clickaction;
  final String id;
  final String status;
  final bool notices;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      clickaction: json["click_action"],
      id: json["id"],
      status: json["status"],
      notices: json["notice"]);

  Map<String, dynamic> toJson() => {
        "click_action": clickaction,
        "id": id,
        "status": status,
        "notice": notices,
      };
}

class Notification {
  Notification({
    required this.body,
    required this.title,
  });

  final String body;
  final String title;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
        "android_channel_id": "android_channel_id",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      };
}
