// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.status,
    required this.response,
    this.code,
  });

  dynamic status;
  List<CityModelResponse> response;
  dynamic code;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        status: json["status"],
        response: List<CityModelResponse>.from(
            json["response"].map((x) => CityModelResponse.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "code": code,
      };
}

class CityModelResponse {
  CityModelResponse({
    this.id,
    this.city,
    this.stateId,
    this.countryId,
    this.countryName,
    this.stateName,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.deletedAt,
  });

  dynamic id;
  dynamic city;
  dynamic stateId;
  dynamic countryId;
  dynamic countryName;
  dynamic stateName;
  dynamic createdAt;
  dynamic createdBy;
  dynamic updatedAt;
  dynamic deletedAt;

  factory CityModelResponse.fromJson(Map<String, dynamic> json) =>
      CityModelResponse(
        id: json["id"],
        city: json["city"],
        stateId: json["state_id"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state_id": stateId,
        "country_id": countryId,
        "country_name": countryName,
        "state_name": stateName,
        "created_at": createdAt,
        "created_by": createdBy,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
