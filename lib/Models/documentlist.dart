// To parse this JSON data, do
//
//     final documentListModel = documentListModelFromMap(jsonString);

import 'dart:convert';

DocumentListModel documentListModelFromMap(String str) =>
    DocumentListModel.fromMap(json.decode(str));

String documentListModelToMap(DocumentListModel data) =>
    json.encode(data.toMap());

class DocumentListModel {
  DocumentListModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<DocumentListResponse> response;
  final int code;

  factory DocumentListModel.fromMap(Map<String, dynamic> json) =>
      DocumentListModel(
        status: json["status"] == null ? null : json["status"],
        response: List<DocumentListResponse>.from(
            json["response"].map((x) => DocumentListResponse.fromMap(x))),
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

class DocumentListResponse {
  DocumentListResponse({
    required this.id,
    required this.applicationId,
    required this.document,
    required this.remarks,
    required this.originalDocument,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic id;
  final dynamic applicationId;
  final dynamic document;
  final dynamic remarks;
  final dynamic originalDocument;

  final dynamic status;

  final dynamic createdAt;
  final dynamic updatedAt;

  factory DocumentListResponse.fromMap(Map<String, dynamic> json) =>
      DocumentListResponse(
        id: json["id"] == null ? null : json["id"],
        applicationId:
            json["application_id"] == null ? null : json["application_id"],
        document: json["document"] == null ? null : json["document"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        originalDocument: json["original_document"] == null
            ? null
            : json["original_document"],
        status: json["status"] == null ? null : json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "application_id": applicationId == null ? null : applicationId,
        "document": document == null ? null : document,
        "remarks": remarks == null ? null : remarks,
        "original_document": originalDocument == null ? null : originalDocument,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
