// To parse this JSON data, do
//
//     final admissionShowModel = admissionShowModelFromMap(jsonString);

import 'dart:convert';

AdmissionShowModel admissionShowModelFromMap(String str) =>
    AdmissionShowModel.fromMap(json.decode(str));

String admissionShowModelToMap(AdmissionShowModel data) =>
    json.encode(data.toMap());

class AdmissionShowModel {
  AdmissionShowModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final AdmissionShowResponse response;
  final int code;

  factory AdmissionShowModel.fromMap(Map<String, dynamic> json) =>
      AdmissionShowModel(
        status: json["status"] == null ? null : json["status"],
        response: AdmissionShowResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class AdmissionShowResponse {
  AdmissionShowResponse({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.collegeName,
    required this.courseName,
    required this.courseDuration,
    required this.courseDurationType,
    required this.totalCourseFee,
    required this.status,
    required this.commisionAmount,
    required this.firstYearFeePaid,
    required this.feeHistory,
  });

  final dynamic id;
  final dynamic name;
  final dynamic imageUrl;
  final dynamic collegeName;
  final dynamic courseName;
  final dynamic courseDuration;
  final dynamic courseDurationType;
  final dynamic totalCourseFee;
  final dynamic status;
  final dynamic commisionAmount;
  final dynamic firstYearFeePaid;
  final List<FeeHistory> feeHistory;

  factory AdmissionShowResponse.fromMap(Map<String, dynamic> json) =>
      AdmissionShowResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        courseName: json["course_name"] == null ? null : json["course_name"],
        courseDuration:
            json["course_duration"] == null ? null : json["course_duration"],
        courseDurationType: json["course_duration_type"] == null
            ? null
            : json["course_duration_type"],
        totalCourseFee:
            json["total_course_fee"] == null ? null : json["total_course_fee"],
        status: json["status"] == null ? null : json["status"],
        commisionAmount:
            json["commision_amount"] == null ? null : json["commision_amount"],
        firstYearFeePaid: json["first_year_fee_paid"] == null
            ? null
            : json["first_year_fee_paid"],
        feeHistory: List<FeeHistory>.from(
            json["fee_history"].map((x) => FeeHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image_url": imageUrl == null ? null : imageUrl,
        "college_name": collegeName == null ? null : collegeName,
        "course_name": courseName == null ? null : courseName,
        "course_duration": courseDuration == null ? null : courseDuration,
        "course_duration_type":
            courseDurationType == null ? null : courseDurationType,
        "total_course_fee": totalCourseFee == null ? null : totalCourseFee,
        "status": status == null ? null : status,
        "commision_amount": commisionAmount == null ? null : commisionAmount,
        "first_year_fee_paid":
            firstYearFeePaid == null ? null : firstYearFeePaid,
        "fee_history": feeHistory == null
            ? null
            : List<dynamic>.from(feeHistory.map((x) => x.toMap())),
      };
}

class FeeHistory {
  FeeHistory({
    required this.id,
    this.transactionId,
    this.stdTransactionId,
    required this.receiptId,
    required this.admissionId,
    required this.date,
    required this.courseDurationValue,
    required this.paymentStatus,
    this.paymentMode,
    required this.collectedRoleBy,
    required this.collectedBy,
    required this.paidAmount,
    required this.feeReceipt,
    required this.remarks,
    required this.status,
    this.attachment,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final dynamic id;
  final dynamic transactionId;
  final dynamic stdTransactionId;
  final dynamic receiptId;
  final dynamic admissionId;
  final dynamic date;
  final dynamic courseDurationValue;
  final dynamic paymentStatus;
  final dynamic paymentMode;
  final dynamic collectedRoleBy;
  final dynamic collectedBy;
  final dynamic paidAmount;
  final dynamic feeReceipt;
  final dynamic remarks;
  final dynamic status;
  final dynamic attachment;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory FeeHistory.fromMap(Map<String, dynamic> json) => FeeHistory(
        id: json["id"] == null ? null : json["id"],
        transactionId: json["transaction_id"],
        stdTransactionId: json["std_transaction_id"],
        receiptId: json["receipt_id"] == null ? null : json["receipt_id"],
        admissionId: json["admission_id"] == null ? null : json["admission_id"],
        date: DateTime.parse(json["date"]),
        courseDurationValue: json["course_duration_value"] == null
            ? null
            : json["course_duration_value"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        paymentMode: json["payment_mode"],
        collectedRoleBy: json["collected_role_by"] == null
            ? null
            : json["collected_role_by"],
        collectedBy: json["collected_by"] == null ? null : json["collected_by"],
        paidAmount: json["paid_amount"] == null ? null : json["paid_amount"],
        feeReceipt: json["fee_receipt"] == null ? null : json["fee_receipt"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        status: json["status"] == null ? null : json["status"],
        attachment: json["attachment"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "transaction_id": transactionId,
        "std_transaction_id": stdTransactionId,
        "receipt_id": receiptId == null ? null : receiptId,
        "admission_id": admissionId == null ? null : admissionId,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "course_duration_value":
            courseDurationValue == null ? null : courseDurationValue,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "payment_mode": paymentMode,
        "collected_role_by": collectedRoleBy == null ? null : collectedRoleBy,
        "collected_by": collectedBy == null ? null : collectedBy,
        "paid_amount": paidAmount == null ? null : paidAmount,
        "fee_receipt": feeReceipt == null ? null : feeReceipt,
        "remarks": remarks == null ? null : remarks,
        "status": status == null ? null : status,
        "attachment": attachment,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
