// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final Response response;
  final int code;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        response: Response.fromMap(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toMap(),
        "code": code == null ? null : code,
      };
}

class Response {
  Response({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.bloodType,
    required this.createdBy,
    required this.createdAt,
    required this.roles,
  });

  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic avatar;
  final dynamic phone;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final dynamic address;
  final dynamic bloodType;
  final dynamic createdBy;
  final dynamic createdAt;
  final List<String> roles;

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        phone: json["phone"] == null ? null : json["phone"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        address: json["address"] == null ? null : json["address"],
        bloodType: json["blood_type"] == null ? null : json["blood_type"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "avatar": avatar == null ? null : avatar,
        "phone": phone == null ? null : phone,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "country_id": countryId == null ? null : countryId,
        "state_id": stateId == null ? null : stateId,
        "city_id": cityId == null ? null : cityId,
        "address": address == null ? null : address,
        "blood_type": bloodType == null ? null : bloodType,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt == null ? null : createdAt,
        "roles": roles == null ? null : List<dynamic>.from(roles.map((x) => x)),
      };
}
