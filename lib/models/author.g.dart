// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author()
    ..membershipSchema = json['membershipSchema'] as String
    ..keepValue = json['keepValue'] as num
    ..gender = json['gender'] as String
    ..verifiedIconResourceIdWithSide =
        json['verifiedIconResourceIdWithSide'] as String
    ..bio = json['bio'] as String
    ..memberStatus = json['memberStatus'] as num
    ..avatar = json['avatar'] as String
    ..maxKeepValue = json['maxKeepValue'] as num
    ..verifiedIconUrlWithSide = json['verifiedIconUrlWithSide'] as String
    ..kgLevel = json['kgLevel'] as num
    ..verifiedIconResourceId = json['verifiedIconResourceId'] as String
    ..verifiedIconUrl = json['verifiedIconUrl'] as String
    ..verifyType = json['verifyType'] as num
    ..username = json['username'] as String;
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'membershipSchema': instance.membershipSchema,
      'keepValue': instance.keepValue,
      'gender': instance.gender,
      'verifiedIconResourceIdWithSide': instance.verifiedIconResourceIdWithSide,
      'bio': instance.bio,
      'memberStatus': instance.memberStatus,
      'avatar': instance.avatar,
      'maxKeepValue': instance.maxKeepValue,
      'verifiedIconUrlWithSide': instance.verifiedIconUrlWithSide,
      'kgLevel': instance.kgLevel,
      'verifiedIconResourceId': instance.verifiedIconResourceId,
      'verifiedIconUrl': instance.verifiedIconUrl,
      'verifyType': instance.verifyType,
      'username': instance.username
    };
