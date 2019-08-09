import 'package:flutter/material.dart';

class Z6Color {
  //keep
  static Color deep_kgray = Color(0xff564f5f);
  static Color kgray = Color(0xff999999);
  static Color light_kgray = Color(0xff9a9a9a);
  static Color bg_gray = Color(0xfffafafa);
  static Color black_3 = Color(0xff333333);
  static Color vip_color = Color(0xffefd297);

  static Color primary = Color(0xff564f5f);
  static Color secondary = Color(0xFF51DEC6);
  static Color red = Color(0xFFFF2B45);
  static Color orange = Color(0xFFF67264);
  static Color white = Color(0xFFFFFFFF);
  static Color paper = Color(0xFFF5F5F5);
  static Color lightGray = Color(0xFFEEEEEE);
  static Color darkGray = Color(0xFF333333);
  static Color gray = Color(0xFF888888);
  static Color blue = Color(0xFF3688FF);
  static Color golden = Color(0xff8B7961);

  static Color getColor(List rgbs) {
    return Color.fromARGB(1, rgbs[0], rgbs[1], rgbs[2]);
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}
