// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Explore_rsp _$Explore_rspFromJson(Map<String, dynamic> json) {
  return Explore_rsp()
    ..ok = json['ok'] as bool
    ..data = json['data'] as Map<String, dynamic>
    ..errorCode = json['errorCode'] as num
    ..text = json['text'] as String;
}

Map<String, dynamic> _$Explore_rspToJson(Explore_rsp instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
      'errorCode': instance.errorCode,
      'text': instance.text
    };
