import 'package:json_annotation/json_annotation.dart';
import "entry.dart";
part 'entrys.g.dart';
@JsonSerializable()
class Entrys {
    Entrys();
    String pattern;
    Entry entry;
    num position;
    
    factory Entrys.fromJson(Map<String,dynamic> json) => _$EntrysFromJson(json);
    Map<String, dynamic> toJson() => _$EntrysToJson(this);
}