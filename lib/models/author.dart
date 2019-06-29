import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';
@JsonSerializable()
class Author {
    Author();
    String membershipSchema;
    num keepValue;
    String gender;
    String verifiedIconResourceIdWithSide;
    String bio;
    num memberStatus;
    String avatar;
    num maxKeepValue;
    String verifiedIconUrlWithSide;
    num kgLevel;
    String verifiedIconResourceId;
    String verifiedIconUrl;
    num verifyType;
    String username;
    
    factory Author.fromJson(Map<String,dynamic> json) => _$AuthorFromJson(json);
    Map<String, dynamic> toJson() => _$AuthorToJson(this);
}