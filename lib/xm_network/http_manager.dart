import 'package:dio/dio.dart';
import 'dart:async';

import 'api.dart';

/*
 * 封装 restful 请求
 * 
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class Z6HttpManager {
  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'https://api.gotokeep.com/feed/v1/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  /// request method
  /// GET
  static Future<Map> get(String url, {params}) async {
    return await request(url, params: params);
  }

  static Future<Map> request(
    String url, {
    params,
    data,
    method,
  }) async {
    data = data ?? {};
    params = params ?? {};
    method = method ?? 'get';

    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    String pramas =
        data.toString() != '{}' ? data.toString() : params.toString();

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求方式：$method');
    print('请求地址：$url');
    print('请求参数：$pramas');

    Dio dio = createInstance();
    dio.options.method = method;
    var result;

    try {
      Response response = await (Z6HttpManager.GET == method
          ? dio.request(url, queryParameters: params)
          : dio.request(url, data: data));

      result = response.data;

      /// 打印响应相关信息
      // print('响应数据：' + response.toString());
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      // 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        baseUrl: Api.prefix,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = Dio(options);
      // dio.options.baseUrl = Api.PREFIX;
      // dio = new Dio(options);
    }

    dio = new Dio();
    dio.options.baseUrl = Api.prefix;
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
