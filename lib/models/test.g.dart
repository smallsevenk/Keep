// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test()
    ..count = json['count'] as num
    ..next = json['next'] as String
    ..previous = json['previous'] as String
    ..results = json['results'] as List;
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results
    };
