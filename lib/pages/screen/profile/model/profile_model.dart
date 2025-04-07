import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProfileModel {
  int statusCode;
  String status;
  Result result;

  ProfileModel({
    required this.statusCode,
    required this.status,
    required this.result,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        statusCode: json["statusCode"],
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "result": result.toJson(),
      };
}

class Result {
  int id;
  int userId;
  String lastName;
  String firstName;
  String email;
  String? avatarUrl;

  Result({
    required this.id,
    required this.userId,
    required this.lastName,
    required this.firstName,
    required this.email,
    this.avatarUrl,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["userId"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        email: json["email"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "lastName": lastName,
        "firstName": firstName,
        "email": email,
        "avatarUrl": avatarUrl,
      };
}
