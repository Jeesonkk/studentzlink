// To parse this JSON data, do
//
//     final applicationShowModel = applicationShowModelFromMap(jsonString);

import 'dart:convert';

ApplicationShowModel applicationShowModelFromMap(String str) =>
    ApplicationShowModel.fromMap(json.decode(str));

String applicationShowModelToMap(ApplicationShowModel data) =>
    json.encode(data.toMap());

class ApplicationShowModel {
  ApplicationShowModel({
    this.status,
    required this.response,
    this.code,
  });

  final dynamic status;
  final ApplicationShowResponse response;
  final dynamic code;

  factory ApplicationShowModel.fromMap(Map<String, dynamic> json) =>
      ApplicationShowModel(
        status: json["status"] == null ? null : json["status"],
        response: ApplicationShowResponse.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class ApplicationShowResponse {
  ApplicationShowResponse({
    this.id,
    this.applicationId,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.course,
    this.collegeName,
    this.duration,
    this.courseFee,
    this.courseStartYear,
    this.courseEndYear,
    this.parentName,
    this.dateOfBirth,
    this.email,
    this.phone,
    this.parentPhone,
    this.address,
    this.applicationFee,
    this.country,
    this.countryId,
    this.state,
    this.stateId,
    this.city,
    this.cityId,
    this.collegeId,
    this.courseId,
    this.batchId,
    this.batchName,
    this.attachment,
  });

  final dynamic id;
  final dynamic applicationId;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic imageUrl;
  final dynamic course;
  final dynamic collegeName;
  final dynamic duration;
  final dynamic courseFee;
  final dynamic courseStartYear;
  final dynamic courseEndYear;
  final dynamic parentName;
  final dynamic dateOfBirth;
  final dynamic email;
  final dynamic phone;
  final dynamic parentPhone;
  final dynamic address;
  final dynamic applicationFee;
  final dynamic country;
  final dynamic countryId;
  final dynamic state;
  final dynamic stateId;
  final dynamic city;
  final dynamic cityId;
  final dynamic collegeId;
  final dynamic courseId;
  final dynamic batchId;
  final dynamic batchName;
  final dynamic attachment;

  factory ApplicationShowResponse.fromMap(Map<String, dynamic> json) =>
      ApplicationShowResponse(
        id: json["id"] == null ? null : json["id"],
        applicationId:
            json["application_id"] == null ? null : json["application_id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        course: json["course"] == null ? null : json["course"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        duration: json["duration"] == null ? null : json["duration"],
        courseFee: json["course_fee"] == null ? null : json["course_fee"],
        courseStartYear: json["course_start_year"] == null
            ? null
            : json["course_start_year"],
        courseEndYear:
            json["course_end_year"] == null ? null : json["course_end_year"],
        parentName: json["parent_name"] == null ? null : json["parent_name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        parentPhone: json["parent_phone"] == null ? null : json["parent_phone"],
        address: json["address"] == null ? null : json["address"],
        applicationFee:
            json["application_fee"] == null ? null : json["application_fee"],
        country: json["country"] == null ? null : json["country"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        state: json["state"] == null ? null : json["state"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        city: json["city"] == null ? null : json["city"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
        courseId: json["course_id"] == null ? null : json["course_id"],
        batchId: json["batch_id"] == null ? null : json["batch_id"],
        batchName: json["batch_name"] == null ? null : json["batch_name"],
        attachment: json["attachment"] == null ? null : json["attachment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "application_id": applicationId == null ? null : applicationId,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image_url": imageUrl == null ? null : imageUrl,
        "course": course == null ? null : course,
        "college_name": collegeName == null ? null : collegeName,
        "duration": duration == null ? null : duration,
        "course_fee": courseFee == null ? null : courseFee,
        "course_start_year": courseStartYear == null ? null : courseStartYear,
        "course_end_year": courseEndYear == null ? null : courseEndYear,
        "parent_name": parentName == null ? null : parentName,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "parent_phone": parentPhone == null ? null : parentPhone,
        "address": address == null ? null : address,
        "application_fee": applicationFee == null ? null : applicationFee,
        "country": country == null ? null : country,
        "country_id": countryId == null ? null : countryId,
        "state": state == null ? null : state,
        "state_id": stateId == null ? null : stateId,
        "city": city == null ? null : city,
        "city_id": cityId == null ? null : cityId,
        "college_id": collegeId == null ? null : collegeId,
        "course_id": courseId == null ? null : courseId,
        "batch_id": batchId == null ? null : batchId,
        "batch_name": batchName == null ? null : batchName,
        "attachment": attachment == null ? null : attachment,
      };
}
