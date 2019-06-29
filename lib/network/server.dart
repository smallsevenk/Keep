import 'package:keep/base/public.dart';

class Z6Srv {
  static Future<Map> queryHot() async {
    var result = await Z6HttpManager.get(Api.Hot, params: {
      "feedType": "hot",
      "needCommentInfo": "1",
      "needFavoriteInfo": "1",
      "needLikeInfo": "1",
      "needRelationInfo": "1",
      "position": "0",
      "sort": "byTime"
    });
    return result;
  }
}
