// To parse this JSON data, do
//
//     final roleListModel = roleListModelFromMap(jsonString);

import 'dart:convert';

RoleListModel roleListModelFromMap(String str) =>
    RoleListModel.fromMap(json.decode(str));

String roleListModelToMap(RoleListModel data) => json.encode(data.toMap());

class RoleListModel {
  RoleListModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<RolesResponse> response;
  final int code;

  factory RoleListModel.fromMap(Map<String, dynamic> json) => RoleListModel(
        status: json["status"] == null ? null : json["status"],
        response: List<RolesResponse>.from(
            json["response"].map((x) => RolesResponse.fromMap(x))),
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

class RolesResponse {
  RolesResponse({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic id;
  final dynamic name;
  final dynamic guardName;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory RolesResponse.fromMap(Map<String, dynamic> json) => RolesResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        guardName: json["guard_name"] == null ? null : json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "guard_name": guardName == null ? null : guardName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
