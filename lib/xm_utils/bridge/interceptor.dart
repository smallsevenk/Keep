part of 'bridge.dart';

enum InterceptorHandleType {
  /// 发送到下一个拦截器
  Next,

  /// 不在发送
  Break,

  /// 表示拦截器已经处理了请求，当作正常处理完毕
  Done,

  /// 强制拦截
  Refused
}

abstract class BridgeInterceptor {
  /// 进入处理之前，返回true则视为需要对该请求做出postHandle操作
  bool preHandle(HttpRequest request, Uint8List body, HttpServer server);

  /// 处理过程，返回true表示已处理，不需要接续发送，返回false则表示继续向下发送请求
  InterceptorHandleType postHandle(
      HttpRequest request, Uint8List body, HttpServer server);

  /// 处理完毕后
  void afterCompletion(
      HttpRequest request, HttpServer server, dynamic response);
}

/// 测试拦截器，处理所有请求但是打印参数
class LogInterceptor implements BridgeInterceptor {
  /// 进入处理之前，返回true则为处理，否则截断不在继续发送
  bool preHandle(HttpRequest request, Uint8List body, HttpServer server) {
    final jsonObject = jsonDecode(utf8.decode(body));
    print('-> ${jsonObject['method']} : ${jsonObject['params']}');
    return false;
  }

  /// 处理过程
  InterceptorHandleType postHandle(
      HttpRequest request, Uint8List body, HttpServer server) {
    return InterceptorHandleType.Next;
  }

  /// 处理完毕后
  void afterCompletion(
      HttpRequest request, HttpServer server, dynamic response) {
    print('<- $response');
  }
}
