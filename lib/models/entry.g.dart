// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry()
    ..country = json['country'] as String
    ..reason = json['reason'] as String
    ..achievements = json['achievements'] as List
    ..internalShareCount = json['internalShareCount'] as num
    ..stateValue = json['stateValue'] as num
    ..feel = json['feel'] as num
    ..type = json['type'] as String
    ..contentTypeStr = json['contentTypeStr'] as String
    ..relation = json['relation'] as num
    ..hashTags = json['hashTags'] as List
    ..province = json['province'] as String
    ..citycode = json['citycode'] as String
    ..id = json['id'] as String
    ..state = json['state'] as String
    ..contentType = json['contentType'] as List
    ..likes = json['likes'] as num
    ..images = json['images'] as List
    ..author = json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>)
    ..created = json['created'] as String
    ..expansion = json['expansion'] as Map<String, dynamic>
    ..quality = json['quality'] as num
    ..meta = json['meta'] as Map<String, dynamic>
    ..commentUsers = json['commentUsers'] as num
    ..vlog = json['vlog'] as bool
    ..schema = json['schema'] as String
    ..city = json['city'] as String
    ..timezone = json['timezone'] as String
    ..content = json['content'] as String
    ..geo = json['geo'] as List
    ..public = json['public'] as bool
    ..noise = json['noise'] as bool
    ..sampleComments = json['sampleComments'] as List
    ..likeRank = json['likeRank'] as List
    ..viewCount = json['viewCount'] as num
    ..place = json['place'] as String
    ..isAd = json['isAd'] as bool
    ..nationCode = json['nationCode'] as String
    ..comments = json['comments'] as num
    ..photo = json['photo'] as String
    ..squadDayIndex = json['squadDayIndex'] as num
    ..likeStatistics = json['likeStatistics'] as Map<String, dynamic>
    ..clientIp = json['clientIp'] as String
    ..manualViewCount = json['manualViewCount'] as num
    ..externalShareCount = json['externalShareCount'] as num
    ..favoriteCount = json['favoriteCount'] as num;
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'country': instance.country,
      'reason': instance.reason,
      'achievements': instance.achievements,
      'internalShareCount': instance.internalShareCount,
      'stateValue': instance.stateValue,
      'feel': instance.feel,
      'type': instance.type,
      'contentTypeStr': instance.contentTypeStr,
      'relation': instance.relation,
      'hashTags': instance.hashTags,
      'province': instance.province,
      'citycode': instance.citycode,
      'id': instance.id,
      'state': instance.state,
      'contentType': instance.contentType,
      'likes': instance.likes,
      'images': instance.images,
      'author': instance.author,
      'created': instance.created,
      'expansion': instance.expansion,
      'quality': instance.quality,
      'meta': instance.meta,
      'commentUsers': instance.commentUsers,
      'vlog': instance.vlog,
      'schema': instance.schema,
      'city': instance.city,
      'timezone': instance.timezone,
      'content': instance.content,
      'geo': instance.geo,
      'public': instance.public,
      'noise': instance.noise,
      'sampleComments': instance.sampleComments,
      'likeRank': instance.likeRank,
      'viewCount': instance.viewCount,
      'place': instance.place,
      'isAd': instance.isAd,
      'nationCode': instance.nationCode,
      'comments': instance.comments,
      'photo': instance.photo,
      'squadDayIndex': instance.squadDayIndex,
      'likeStatistics': instance.likeStatistics,
      'clientIp': instance.clientIp,
      'manualViewCount': instance.manualViewCount,
      'externalShareCount': instance.externalShareCount,
      'favoriteCount': instance.favoriteCount
    };
