// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hot _$HotFromJson(Map<String, dynamic> json) {
  return Hot()
    ..errorCode = json['errorCode'] as num
    ..text = json['text'] as String
    ..data = json['data'] == null
        ? null
        : Items.fromJson(json['data'] as Map<String, dynamic>)
    ..now = json['now'] as String
    ..version = json['version'] as String
    ..ok = json['ok'] as bool;
}

Map<String, dynamic> _$HotToJson(Hot instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'text': instance.text,
      'data': instance.data,
      'now': instance.now,
      'version': instance.version,
      'ok': instance.ok
    };
