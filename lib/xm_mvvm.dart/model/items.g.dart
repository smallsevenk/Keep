// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items()
    ..lastId = json['lastId'] as String
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Entrys.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ItemsToJson(Items instance) =>
    <String, dynamic>{'lastId': instance.lastId, 'items': instance.items};
