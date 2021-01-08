import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpLogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint("请求baseUrl：${options.baseUrl}");
    debugPrint("请求url：${options.path}");
    debugPrint('请求头: ' + options.headers.toString());
    if (options.data != null) {
      debugPrint('请求参数: ' + options.data.toString());
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (response != null) {
      // var responseStr = response.toString();
    }

    return response; // continue
  }

  @override
  onError(DioError err) async {
    debugPrint('请求异常: ' + err.toString());
    debugPrint('请求异常信息: ' + err.response?.toString() ?? "");
    return err;
  }
}
