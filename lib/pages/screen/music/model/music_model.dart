import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'music_model.g.dart';

MusicModel musicModelFromJson(String str) =>
    MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

@JsonSerializable()
class MusicModel {
  int statusCode;
  String status;
  List<Result> result;

  MusicModel({
    required this.statusCode,
    required this.status,
    required this.result,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
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
  String? musicUrl;
  String? file;
  String? saffron;
  String? alto;
  String? tenor;
  String? bass;
  DateTime createdAt;
  DateTime updatedAt;

  Result({
    required this.id,
    required this.title,
    required this.musicUrl,
    required this.file,
    required this.saffron,
    required this.alto,
    required this.tenor,
    required this.bass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        musicUrl: json["musicUrl"],
        file: json["file"],
        saffron: json["saffron"],
        alto: json["alto"],
        tenor: json["tenor"],
        bass: json["bass"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "musicUrl": musicUrl,
        "file": file,
        "saffron": saffron,
        "alto": alto,
        "tenor": tenor,
        "bass": bass,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
