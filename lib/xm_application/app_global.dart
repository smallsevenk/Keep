import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:framework/xm_widgets/widgets_config.dart';
import 'package:framework/xm_application/app_enum.dart';
import 'package:framework/xm_utils/environment/evn_model.dart';

class XMAppGlobal {
  // 环境配置
  static XMEnvModel lmEnv;
  static String lmAppConfigBaseURL = '${lmEnv.baseUrl}/dappConfig/app/';
  static String lmDappBaseURL = '${lmEnv.baseUrl}/#/';
  static bool screenInited = false;

  static Future init() async {
    XMCtlsConfig(XMAPPStyle.Style1);
  }

  void initFlutterDownloader() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.isPhysicalDevice) {
        // await FlutterDownloader.initialize();
        // userFlutterDownloader = true;
      }
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.isPhysicalDevice) {}
    }
  }
}
