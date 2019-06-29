import 'package:json_annotation/json_annotation.dart';

part 'keep.g.dart';

@JsonSerializable()
class KeepRsp {
  final int count;
  // final String name;
  // final String content;
  // final String likes;
  // final String avatar;
  KeepRsp({this.count});
  // KeepRsp({this.name, this.content, this.likes, this.avatar});

  //反序列化
  factory KeepRsp.fromJson(Map<String, dynamic> json) =>
      _$KeepRspFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$KeepRspToJson(this);
}
