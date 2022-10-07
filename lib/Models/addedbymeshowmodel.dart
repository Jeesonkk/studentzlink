// To parse this JSON data, do
//
//     final addedbymeShowModel = addedbymeShowModelFromMap(jsonString);

import 'dart:convert';

AddedbymeShowModel addedbymeShowModelFromMap(String str) =>
    AddedbymeShowModel.fromMap(json.decode(str));

String addedbymeShowModelToMap(AddedbymeShowModel data) =>
    json.encode(data.toMap());

class AddedbymeShowModel {
  AddedbymeShowModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final TaskShowResponse response;
  final int code;

  factory AddedbymeShowModel.fromMap(Map<String, dynamic> json) =>
      AddedbymeShowModel(
        status: json["status"] == null ? null : json["status"],
        response: TaskShowResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class TaskShowResponse {
  TaskShowResponse({
    required this.id,
    required this.name,
    required this.status,
    required this.task,
    required this.assignedTo,
    required this.assignedToUser,
    required this.date,
    required this.time,
    this.remarks,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.history,
  });

  final dynamic id;
  final dynamic name;
  final dynamic status;
  final dynamic task;
  final dynamic assignedTo;
  final dynamic assignedToUser;
  final dynamic date;
  final dynamic time;
  final dynamic remarks;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final List<History> history;

  factory TaskShowResponse.fromMap(Map<String, dynamic> json) =>
      TaskShowResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        task: json["task"] == null ? null : json["task"],
        assignedTo: json["assigned_to"] == null ? null : json["assigned_to"],
        assignedToUser:
            json["assigned_to_user"] == null ? null : json["assigned_to_user"],
        date: DateTime.parse(json["date"]),
        time: json["time"] == null ? null : json["time"],
        remarks: json["remarks"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        history:
            List<History>.from(json["history"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "task": task == null ? null : task,
        "assigned_to": assignedTo == null ? null : assignedTo,
        "assigned_to_user": assignedToUser == null ? null : assignedToUser,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time == null ? null : time,
        "remarks": remarks,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "history": history == null
            ? null
            : List<dynamic>.from(history.map((x) => x.toMap())),
      };
}

class History {
  History({
    required this.id,
    required this.taskId,
    required this.history,
    this.remarks,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic id;
  final dynamic taskId;
  final dynamic history;
  final dynamic remarks;
  final dynamic createdBy;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory History.fromMap(Map<String, dynamic> json) => History(
        id: json["id"] == null ? null : json["id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        history: json["history"] == null ? null : json["history"],
        remarks: json["remarks"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "task_id": taskId == null ? null : taskId,
        "history": history == null ? null : history,
        "remarks": remarks,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
