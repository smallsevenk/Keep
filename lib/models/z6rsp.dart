import 'package:json_annotation/json_annotation.dart';

part 'z6rsp.g.dart';

@JsonSerializable()
class Z6Rsp {
  final int errorCode; //错误信息
  final String text;
  final String now; //时间
  final String version; //版本号
  final bool ok; //状态

  Z6Rsp(this.errorCode, this.text, this.now, this.version, this.ok);

  //反序列化
  factory Z6Rsp.fromJson(Map<String, dynamic> json) => _$Z6RspFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$Z6RspToJson(this);
}
