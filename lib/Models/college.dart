// To parse this JSON data, do
//
//     final collegeModel = collegeModelFromMap(jsonString);

import 'dart:convert';

CollegeModel collegeModelFromMap(String str) =>
    CollegeModel.fromMap(json.decode(str));

String collegeModelToMap(CollegeModel data) => json.encode(data.toMap());

class CollegeModel {
  CollegeModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<CollegeResponse> response;
  final int code;

  factory CollegeModel.fromMap(Map<String, dynamic> json) => CollegeModel(
        status: json["status"],
        response: List<CollegeResponse>.from(
            json["response"].map((x) => CollegeResponse.fromMap(x))),
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

class CollegeResponse {
  CollegeResponse({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.link,
  });

  final dynamic id;
  final dynamic name;
  final dynamic logoUrl;
  final dynamic link;

  factory CollegeResponse.fromMap(Map<String, dynamic> json) => CollegeResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        logoUrl: json["logo_url"] == null ? null : json["logo_url"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo_url": logoUrl == null ? null : logoUrl,
        "link": link == null ? null : link,
      };
}
