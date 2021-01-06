// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entrys _$EntrysFromJson(Map<String, dynamic> json) {
  return Entrys()
    ..pattern = json['pattern'] as String
    ..entry = json['entry'] == null
        ? null
        : Entry.fromJson(json['entry'] as Map<String, dynamic>)
    ..position = json['position'] as num;
}

Map<String, dynamic> _$EntrysToJson(Entrys instance) => <String, dynamic>{
      'pattern': instance.pattern,
      'entry': instance.entry,
      'position': instance.position
    };
