// To parse this JSON data, do
//
//     final teamListModel = teamListModelFromMap(jsonString);

import 'dart:convert';

TeamListModel teamListModelFromMap(String str) =>
    TeamListModel.fromMap(json.decode(str));

String teamListModelToMap(TeamListModel data) => json.encode(data.toMap());

class TeamListModel {
  TeamListModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<TeamResponse> response;
  final int code;

  factory TeamListModel.fromMap(Map<String, dynamic> json) => TeamListModel(
        status: json["status"] == null ? null : json["status"],
        response: List<TeamResponse>.from(
            json["response"].map((x) => TeamResponse.fromMap(x))),
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

class TeamResponse {
  TeamResponse({
    required this.id,
    required this.name,
  });

  final dynamic id;
  final dynamic name;

  factory TeamResponse.fromMap(Map<String, dynamic> json) => TeamResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
