import 'package:flutter/services.dart';

xmKeyboradHide() {
  print('xmKeyboradHide');
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

String imgPath(String imgName) {
  return 'res/imgs/$imgName.png';
}
