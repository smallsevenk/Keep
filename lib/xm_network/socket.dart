import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;

import '../public.dart';

class XMWebSocketManager {
  XMWebSocketManager._();
  static XMWebSocketManager _manager;
  factory XMWebSocketManager() {
    if (_manager == null) {
      _manager = XMWebSocketManager._();
    }
    return _manager;
  }

  WebSocket _webSocket;
  int _mktWsId = 0;
  Timer _pingTimer;
  initWebSocket({Function success, Function failure}) async {
    var path = '';
    try {
      _webSocket = await WebSocket.connect(path);

      if (_webSocket.readyState == WebSocket.open) {
        if (null != success) {
          print('WS Connection Successed!!!');
          success();
        }
        _ping();

        _webSocket.listen(_onData, onError: (error) {
          print("WSError == > $error !!!");
        }, onDone: () {
          _cancelPing();
          print("WSConn Closed !!!");
        });
      } else {
        failure();
        print('WS UNOpen !!!');
        return;
      }
    } catch (e) {
      if (null != failure) {
        failure();
      }
      print('WS Connection failed!!!\n$e');
      return;
    }
  }

  /// 发送心跳包
  _ping() {
    _pingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_webSocket.readyState == WebSocket.open) {
        _sendMessage(XMWSConst.apiPing, diyId: XMWSConst.pingId);
      }
    });
  }

  _cancelPing() {
    _pingTimer?.cancel();
  }

  /// 关闭
  closeConnect() {
    if (null != _webSocket) _webSocket.close();
  }

  /// 当前状态
  currentState() {
    switch (_webSocket.readyState) {
      case WebSocket.connecting:
        print('【WebSocket】当前状态 ==> connecting');
        break;
      case WebSocket.open:
        print('【WebSocket】当前状态 ==> open');
        break;
      case WebSocket.closing:
        print('【WebSocket】当前状态 ==> closing');
        break;
      case WebSocket.closed:
        print('【WebSocket】当前状态 ==> closed');
        break;
      default:
    }
  }

  void _sendMessage(String method, {dynamic params, int diyId}) {
    try {
      if (_webSocket.readyState == WebSocket.open) {
        Map data = {};
        data[XMWSConst.id] = diyId ?? _mktWsId++;
        data[XMWSConst.method] = method;
        data[XMWSConst.params] = params ?? [];
        if (method == XMWSConst.apiPing) {
          print('Ping - ' +
              DateUtil.formatDateTime(DateTime.now().toString(),
                  DateFormat.HOUR_MINUTE_SECOND, '/', ':'));
        } else {
          print('ID:${data[XMWSConst.id]} -- Methed:$method \n Params:$params');
        }
        _webSocket.add(convert.jsonEncode(data));
      }
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  subscribe(String method, {dynamic params}) {
    _sendMessage(method + XMWSConst.suffixSub, params: params);
  }

  unsubscribe(String method, {dynamic params}) {
    _sendMessage(method + XMWSConst.suffixUnSub, params: params);
  }

  _onData(dynamic data) {
    if (null == data || data.toString().trim().length <= 0) return;
    try {
      Map rsp = {};
      try {
        rsp = convert.jsonDecode(data);
      } catch (e) {
        print(data);
        Toast.show('数据格式有误!' + e.toString());
        return;
      }

      if (rsp.containsKey(XMWSConst.method) &&
          rsp.containsKey(XMWSConst.params)) {
        String api = rsp[XMWSConst.method].toString().split('.').first;

        if (null != rsp[XMWSConst.params]) {
          // var data = rsp[XMWSConst.params];

          switch (api) {
            // case XMWSConst.apiPrice:
            //   {
            //     XWGlobal.eventBus.fire(MKTPriceCE(data));
            //   }

            //   break;
            // case XMWSConst.apiDepth:
            //   {
            //     XWGlobal.eventBus.fire(MKTDepthCE(data));
            //   }

            //   break;
            // case XMWSConst.apiTicker:
            //   {
            //     XWGlobal.eventBus.fire(MKTTickerCE(data));
            //   }

            //   break;
            // case XMWSConst.apiTrade:
            //   {
            //     XWGlobal.eventBus.fire(MKTTradeCE(data));
            //   }

            //   break;
            // case XMWSConst.apiKline:
            //   {}

            //   break;
          }
        }
      }
    } catch (e) {
      Toast.show('OnDataError:' + e.toString());
    }
  }
}

class XMWSConst {
  static const String id = 'id';
  static const String method = 'method';
  static const String params = 'params';
  static const String suffixSub = '.subscribe';
  static const String suffixUnSub = '.unsubscribe';

  //result
  static const String error = 'error';

  /// API.
  //ping
  static const String apiPing = 'server.ping';
  //价格频道
  static const String apiPrice = 'price';
  //深度频道
  static const String apiDepth = 'depth';
  //交易列表频道
  static const String apiTrade = 'trade';
  //滚动数据频道
  static const String apiTicker = 'ticker';
  //K线频道
  static const String apiKline = 'kline';

  /// APIID
  // ping
  static const int pingId = 0;
}
