import 'package:flutter/material.dart';

class XMColor {
  static Color themeColor = Color(0xff019EDB);

  static Color darkThemeColor = Color(0xff0074BD);

  static Color contentColor = Color(0xffF8F8F8);

  static Color navColor = Colors.white;

  static Color grayColor = Color(0xff999999);

  static Color blueColor = Color(0xff1DACFF);

  static Color get modelBgColor => Color.fromRGBO(0, 0, 0, .4);

  static Color lineColor = Color(0xffE6E6E6);

  //keep
  static Color deepGray = Color(0xff564f5f);
  static Color kgray = Color(0xff999999);
  static Color lightGray = Color(0xff9a9a9a);
  static Color bgGray = Color(0xfffafafa);
  static Color black_3 = Color(0xff333333);
  static Color vipColor = Color(0xffefd297);

  static Color paper = Color(0xFFF5F5F5);
  static Color darkGray = Color(0xFF333333);
  static Color gray = Color(0xFF888888);

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
