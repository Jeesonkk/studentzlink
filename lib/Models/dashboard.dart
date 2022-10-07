// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromMap(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromMap(String str) =>
    DashBoardModel.fromMap(json.decode(str));

String dashBoardModelToMap(DashBoardModel data) => json.encode(data.toMap());

class DashBoardModel {
  DashBoardModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final dynamic status;
  final DashBoardResponse response;
  final dynamic code;

  factory DashBoardModel.fromMap(Map<String, dynamic> json) => DashBoardModel(
        status: json["status"] == null ? null : json["status"],
        response: DashBoardResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class DashBoardResponse {
  DashBoardResponse({
    required this.admission,
    required this.earnings,
    required this.totalApplications,
    required this.applicationPending,
    required this.applicationCancelled,
    required this.applicationApproved,
    required this.tasks,
    required this.fullyPaidStudents,
    required this.notifications,
    required this.collegeAdmission,
  });

  final dynamic admission;
  final dynamic earnings;
  final dynamic totalApplications;
  final dynamic applicationPending;
  final dynamic applicationCancelled;
  final dynamic applicationApproved;
  final dynamic tasks;
  final dynamic fullyPaidStudents;
  final dynamic notifications;
  final List<CollegeAdmission> collegeAdmission;

  factory DashBoardResponse.fromMap(Map<String, dynamic> json) =>
      DashBoardResponse(
        admission: json["admission"] == null ? null : json["admission"],
        earnings: json["earnings"] == null ? null : json["earnings"],
        totalApplications: json["total_applications"] == null
            ? null
            : json["total_applications"],
        applicationPending: json["application_pending"] == null
            ? null
            : json["application_pending"],
        applicationCancelled: json["application_cancelled"] == null
            ? null
            : json["application_cancelled"],
        applicationApproved: json["application_approved"] == null
            ? null
            : json["application_approved"],
        tasks: json["tasks"] == null ? null : json["tasks"],
        fullyPaidStudents: json["fully_paid_students"] == null
            ? null
            : json["fully_paid_students"],
        notifications:
            json["notifications"] == null ? null : json["notifications"],
        collegeAdmission: List<CollegeAdmission>.from(
            json["college_admission"].map((x) => CollegeAdmission.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "admission": admission == null ? null : admission,
        "earnings": earnings == null ? null : earnings,
        "total_applications":
            totalApplications == null ? null : totalApplications,
        "application_pending":
            applicationPending == null ? null : applicationPending,
        "application_cancelled":
            applicationCancelled == null ? null : applicationCancelled,
        "application_approved":
            applicationApproved == null ? null : applicationApproved,
        "tasks": tasks == null ? null : tasks,
        "fully_paid_students":
            fullyPaidStudents == null ? null : fullyPaidStudents,
        "notifications": notifications == null ? null : notifications,
        "college_admission": collegeAdmission == null
            ? null
            : List<dynamic>.from(collegeAdmission.map((x) => x.toMap())),
      };
}

class CollegeAdmission {
  CollegeAdmission({
    required this.id,
    required this.name,
    required this.admissions,
  });

  final dynamic id;
  final dynamic name;
  final dynamic admissions;

  factory CollegeAdmission.fromMap(Map<String, dynamic> json) =>
      CollegeAdmission(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        admissions: json["admissions"] == null ? null : json["admissions"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "admissions": admissions == null ? null : admissions,
      };
}
