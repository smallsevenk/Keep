import 'dart:async';
import 'dart:convert';
import 'package:framework/public.dart';
import 'package:framework/xm_utils/environment/evn_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XMSpUtil {
  /// ----------------------------------------------------------------------
  /// DBVersion数据.

  static String _lmDBVersion = '_lmDBVersion';

  static Future<bool> changeDBVersion(int version) async {
    return (await SpUtil.getInstance()).putInt(_lmDBVersion, version);
  }

  static Future<int> dbVersion() async {
    return (await SpUtil.instance).getInt(_lmDBVersion) ?? 0;
  }

  /// Configs.
  static String _config = '_config';
  static Future<String> config() async {
    return await (await SpUtil.getInstance()).getString(_config);
  }

  /// ----------------------------------------------------------------------
  static Future<void> saveConfig(String configJson) async {
    return await (await SpUtil.getInstance()).putString(_config, configJson);
  }

  /// ----------------------------------------------------------------------
  /// 环境切换.
  static String _env = 'LMEnvInfo';

  static Future<List<XMEnvModel>> lmEnv() async {
    SpUtil util = await SpUtil.getInstance();
    List<XMEnvModel> envs = [];
    var list = util.getStringList(_env) ?? [];
    list.forEach((env) {
      var obj = XMEnvModel.fromJson(jsonDecode(env));
      if (obj.used == '1') {
        XMAppGlobal.lmEnv = obj;
      }
      envs.add(obj);
    });

    return envs;
  }

  static Future<bool> addLMEnv(XMEnvModel env) async {
    SpUtil util = await SpUtil.getInstance();
    var list = util.getStringList(_env) ?? [];
    list.add(jsonEncode(env.toJson()));
    return await util.putStringList(_env, list);
  }

  static Future<bool> delLMEnv(int idx) async {
    SpUtil util = await SpUtil.getInstance();
    List<String> list = util.getStringList(_env);
    list.removeAt(idx);
    return await util.putStringList(_env, list);
  }

  static Future<bool> updateLMEnv(int idx, XMEnvModel env) async {
    SpUtil util = await SpUtil.getInstance();
    List<String> list = util.getStringList(_env);
    list.replaceRange(idx, idx + 1, [jsonEncode(env.toJson())]);
    return await util.putStringList(_env, list);
  }

  static Future<bool> changeEnv(int idx) async {
    SpUtil util = await SpUtil.getInstance();
    List<String> list = util.getStringList(_env);
    for (int i = 0; i < list.length; i++) {
      var obj = XMEnvModel.fromJson(jsonDecode(list[i]));
      obj.used = idx == i ? '1' : '0';
      list.replaceRange(i, i + 1, [jsonEncode(obj.toJson())]);
      XMAppGlobal.lmEnv = obj;
    }
    return await util.putStringList(_env, list);
  }
}

/// 用来做shared_preferences的存储
class SpUtil {
  static SpUtil _instance;
  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }
}
