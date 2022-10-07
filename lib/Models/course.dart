// To parse this JSON data, do
//
//     final courseModel = courseModelFromMap(jsonString);

import 'dart:convert';

CourseModel courseModelFromMap(String str) =>
    CourseModel.fromMap(json.decode(str));

String courseModelToMap(CourseModel data) => json.encode(data.toMap());

class CourseModel {
  CourseModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<CourseListResponse> response;
  final int code;

  factory CourseModel.fromMap(Map<String, dynamic> json) => CourseModel(
        status: json["status"] == null ? null : json["status"],
        response: List<CourseListResponse>.from(
            json["response"].map((x) => CourseListResponse.fromMap(x))),
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

class CourseListResponse {
  CourseListResponse({
    required this.id,
    required this.name,
    required this.totalSeats,
    required this.pendingSeats,
    required this.universityName,
    required this.universityId,
    required this.batches,
  });

  final dynamic id;
  final dynamic name;
  final dynamic totalSeats;
  final dynamic pendingSeats;
  final dynamic universityName;
  final dynamic universityId;
  final List<Batch> batches;

  factory CourseListResponse.fromMap(Map<String, dynamic> json) =>
      CourseListResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        totalSeats: json["total_seats"] == null ? null : json["total_seats"],
        pendingSeats:
            json["pending_seats"] == null ? null : json["pending_seats"],
        universityName:
            json["university_name"] == null ? null : json["university_name"],
        universityId:
            json["university_id"] == null ? null : json["university_id"],
        batches: List<Batch>.from(json["batches"].map((x) => Batch.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "total_seats": totalSeats == null ? null : totalSeats,
        "pending_seats": pendingSeats == null ? null : pendingSeats,
        "university_name": universityName == null ? null : universityName,
        "university_id": universityId == null ? null : universityId,
        "batches": batches == null
            ? null
            : List<dynamic>.from(batches.map((x) => x.toMap())),
      };
}

class Batch {
  Batch({
    required this.id,
    required this.name,
  });

  final dynamic id;
  final dynamic name;

  factory Batch.fromMap(Map<String, dynamic> json) => Batch(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
