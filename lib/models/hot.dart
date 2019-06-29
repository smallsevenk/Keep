import 'package:json_annotation/json_annotation.dart';
import "items.dart";
part 'hot.g.dart';
@JsonSerializable()
class Hot {
    Hot();
    num errorCode;
    String text;
    Items data;
    String now;
    String version;
    bool ok;
    
    factory Hot.fromJson(Map<String,dynamic> json) => _$HotFromJson(json);
    Map<String, dynamic> toJson() => _$HotToJson(this);
}