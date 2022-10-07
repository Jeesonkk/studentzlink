// To parse this JSON data, do
//
//     final taskModel = taskModelFromMap(jsonString);

import 'dart:convert';

TaskModel taskModelFromMap(String str) => TaskModel.fromMap(json.decode(str));

String taskModelToMap(TaskModel data) => json.encode(data.toMap());

class TaskModel {
  TaskModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<TaskListResponse> response;
  final int code;

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        status: json["status"] == null ? null : json["status"],
        response: List<TaskListResponse>.from(
            json["response"].map((x) => TaskListResponse.fromMap(x))),
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

class TaskListResponse {
  TaskListResponse({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.assignedUser,
    this.assignedUserId,
    this.assignedUserRole,
    required this.createdUser,
    required this.createdUserId,
    required this.createdUserRole,
  });

  final int id;
  final dynamic name;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String assignedUser;
  final dynamic assignedUserId;
  final dynamic assignedUserRole;
  final String createdUser;
  final int createdUserId;
  final List<CreatedUserRole> createdUserRole;

  factory TaskListResponse.fromMap(Map<String, dynamic> json) =>
      TaskListResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        assignedUser:
            json["assigned_user"] == null ? null : json["assigned_user"],
        assignedUserId: json["assigned_user_id"],
        assignedUserRole: json["assigned_user_role"],
        createdUser: json["created_user"] == null ? null : json["created_user"],
        createdUserId:
            json["created_user_id"] == null ? null : json["created_user_id"],
        createdUserRole: List<CreatedUserRole>.from(
            json["created_user_role"].map((x) => CreatedUserRole.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "assigned_user": assignedUser == null ? null : assignedUser,
        "assigned_user_id": assignedUserId,
        "assigned_user_role": assignedUserRole,
        "created_user": createdUser == null ? null : createdUser,
        "created_user_id": createdUserId == null ? null : createdUserId,
        "created_user_role": createdUserRole == null
            ? null
            : List<dynamic>.from(createdUserRole.map((x) => x.toMap())),
      };
}

class AssignedUserRoleElement {
  AssignedUserRoleElement({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final dynamic id;
  final dynamic name;
  final dynamic guardName;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Pivot pivot;

  factory AssignedUserRoleElement.fromMap(Map<String, dynamic> json) =>
      AssignedUserRoleElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        guardName: json["guard_name"] == null ? null : json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromMap(json["pivot"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "guard_name": guardName == null ? null : guardName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pivot": pivot == null ? null : pivot.toMap(),
      };
}

class Pivot {
  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  final dynamic modelId;
  final dynamic roleId;
  final dynamic modelType;

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"] == null ? null : json["model_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        modelType: json["model_type"] == null ? null : json["model_type"],
      );

  Map<String, dynamic> toMap() => {
        "model_id": modelId == null ? null : modelId,
        "role_id": roleId == null ? null : roleId,
        "model_type": modelType == null ? null : modelType,
      };
}

class CreatedUserRole {
  CreatedUserRole({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final dynamic id;
  final dynamic name;
  final dynamic guardName;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Pivot pivot;

  factory CreatedUserRole.fromMap(Map<String, dynamic> json) => CreatedUserRole(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        guardName: json["guard_name"] == null ? null : json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromMap(json["pivot"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "guard_name": guardName == null ? null : guardName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pivot": pivot == null ? null : pivot.toMap(),
      };
}
