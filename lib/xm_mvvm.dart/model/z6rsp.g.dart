// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'z6rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Z6Rsp _$Z6RspFromJson(Map<String, dynamic> json) {
  return Z6Rsp(json['errorCode'] as int, json['text'] as String,
      json['now'] as String, json['version'] as String, json['ok'] as bool);
}

Map<String, dynamic> _$Z6RspToJson(Z6Rsp instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'text': instance.text,
      'now': instance.now,
      'version': instance.version,
      'ok': instance.ok
    };
