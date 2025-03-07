import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'banner_model.g.dart';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

@JsonSerializable()
class BannerModel {
  int statusCode;
  String status;
  List<Result> result;

  BannerModel({
    required this.statusCode,
    required this.status,
    required this.result,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        statusCode: json["statusCode"],
        status: json["status"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String title;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Result({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
