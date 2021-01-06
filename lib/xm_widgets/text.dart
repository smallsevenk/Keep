import 'package:flutter/material.dart';
import '../public.dart';

class XMText {
  static Widget create(String text,
      {double ftSize = 48,
      Color color = Colors.black,
      Color bgColor = Colors.transparent,
      FontWeight fontWeight = FontWeight.normal,
      TextOverflow overflow,
      TextAlign algin,
      int maxLines,
      TextDecoration decoration = TextDecoration.none}) {
    return Text(
      text ?? '',
      textAlign: algin,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: xmDp(ftSize),
          backgroundColor: bgColor,
          fontWeight: fontWeight,
          decoration: decoration),
    );
  }
}
