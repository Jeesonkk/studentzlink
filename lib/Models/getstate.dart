// To parse this JSON data, do
//
//     final stateModel = stateModelFromMap(jsonString);

import 'dart:convert';

StateModel stateModelFromMap(String str) =>
    StateModel.fromMap(json.decode(str));

String stateModelToMap(StateModel data) => json.encode(data.toMap());

class StateModel {
  StateModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<StateResponse> response;
  final int code;

  factory StateModel.fromMap(Map<String, dynamic> json) => StateModel(
        status: json["status"] == null ? null : json["status"],
        response: List<StateResponse>.from(
            json["response"].map((x) => StateResponse.fromMap(x))),
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

class StateResponse {
  StateResponse({
    required this.id,
    required this.countryId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final dynamic id;
  final dynamic countryId;
  final dynamic name;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory StateResponse.fromMap(Map<String, dynamic> json) => StateResponse(
        id: json["id"] == null ? null : json["id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "country_id": countryId == null ? null : countryId,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
