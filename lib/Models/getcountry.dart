// To parse this JSON data, do
//
//     final countryModel = countryModelFromMap(jsonString);

import 'dart:convert';

CountryModel countryModelFromMap(String str) =>
    CountryModel.fromMap(json.decode(str));

String countryModelToMap(CountryModel data) => json.encode(data.toMap());

class CountryModel {
  CountryModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<CountryResponse> response;
  final int code;

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        status: json["status"] == null ? null : json["status"],
        response: List<CountryResponse>.from(
            json["response"].map((x) => CountryResponse.fromMap(x))),
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

class CountryResponse {
  CountryResponse({
    required this.id,
    required this.name,
    required this.shortName,
    this.flagImg,
    required this.countryCode,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final dynamic id;
  final dynamic name;
  final dynamic shortName;
  final dynamic flagImg;
  final dynamic countryCode;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory CountryResponse.fromMap(Map<String, dynamic> json) => CountryResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        flagImg: json["flag_img"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "short_name": shortName == null ? null : shortName,
        "flag_img": flagImg,
        "country_code": countryCode == null ? null : countryCode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
