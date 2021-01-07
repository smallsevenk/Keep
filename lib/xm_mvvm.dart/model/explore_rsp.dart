import 'package:json_annotation/json_annotation.dart';

part 'explore_rsp.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class Explore_rsp {
  Explore_rsp();
  bool ok;
  Map<String, dynamic> data;
  num errorCode;
  String text;

  factory Explore_rsp.fromJson(Map<String, dynamic> json) =>
      _$Explore_rspFromJson(json);
  Map<String, dynamic> toJson() => _$Explore_rspToJson(this);
}
