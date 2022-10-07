// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromMap(String str) =>
    NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) =>
    json.encode(data.toMap());

class NotificationModel {
  NotificationModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<NotificationResponse> response;
  final int code;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"] == null ? null : json["status"],
        response: List<NotificationResponse>.from(
            json["response"].map((x) => NotificationResponse.fromMap(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toMap())),
        "code": code == null ? null : code,
      };
}

class NotificationResponse {
  NotificationResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  final dynamic id;
  final dynamic title;
  final dynamic content;
  final dynamic date;

  factory NotificationResponse.fromMap(Map<String, dynamic> json) =>
      NotificationResponse(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "date": date == null ? null : date.toIso8601String(),
      };
}
