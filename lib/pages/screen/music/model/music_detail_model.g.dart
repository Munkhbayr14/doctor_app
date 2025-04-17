// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicDetailModel _$MusicDetailModelFromJson(Map<String, dynamic> json) =>
    MusicDetailModel(
      statusCode: (json['statusCode'] as num).toInt(),
      status: json['status'] as String,
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicDetailModelToJson(MusicDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'status': instance.status,
      'result': instance.result,
    };
