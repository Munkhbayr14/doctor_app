// To parse this JSON data, do
//
//     final musicDetailModel = musicDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'music_detail_model.g.dart';

MusicDetailModel musicDetailModelFromJson(String str) =>
    MusicDetailModel.fromJson(json.decode(str));

String musicDetailModelToJson(MusicDetailModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class MusicDetailModel {
  int statusCode;
  String status;
  Result result;

  MusicDetailModel({
    required this.statusCode,
    required this.status,
    required this.result,
  });

  factory MusicDetailModel.fromJson(Map<String, dynamic> json) =>
      MusicDetailModel(
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
  String title;
  String musicUrl;
  String file;
  dynamic saffron;
  dynamic alto;
  dynamic tenor;
  dynamic bass;
  DateTime createdAt;
  DateTime updatedAt;
  List<Audio> audio;

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
    required this.audio,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"]?.toString() ?? '',
        musicUrl: json['musicUrl']?.toString() ?? '',
        file: json["file"]?.toString() ?? '',
        saffron: json["saffron"]?.toString() ?? '',
        alto: json["alto"]?.toString() ?? '',
        tenor: json["tenor"]?.toString() ?? '',
        bass: json["bass"]?.toString() ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        audio: List<Audio>.from(json["audio"].map((x) => Audio.fromJson(x))),
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
        "audio": List<dynamic>.from(audio.map((x) => x.toJson())),
      };
}

class Audio {
  String voice;
  String url;

  Audio({
    required this.voice,
    required this.url,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        voice: json["voice"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "voice": voice,
        "url": url,
      };
}
