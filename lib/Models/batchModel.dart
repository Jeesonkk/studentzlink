// To parse this JSON data, do
//
//     final batchModel = batchModelFromMap(jsonString);

import 'dart:convert';

BatchModel batchModelFromMap(String str) =>
    BatchModel.fromMap(json.decode(str));

String batchModelToMap(BatchModel data) => json.encode(data.toMap());

class BatchModel {
  BatchModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final dynamic status;
  final List<BatchResponse> response;
  final dynamic code;

  factory BatchModel.fromMap(Map<String, dynamic> json) => BatchModel(
        status: json["status"] == null ? null : json["status"],
        response: List<BatchResponse>.from(
            json["response"].map((x) => BatchResponse.fromMap(x))),
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

class BatchResponse {
  BatchResponse({
    required this.id,
    required this.name,
  });

  final dynamic id;
  final dynamic name;

  factory BatchResponse.fromMap(Map<String, dynamic> json) => BatchResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
