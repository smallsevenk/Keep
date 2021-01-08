import 'package:flutter/services.dart';
import 'package:framework/xm_utils/toast.dart';

commingSoon() {
  Toast.show('Coming soon');
}

xmKeyboradHide() {
  print('xmKeyboradHide');
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

String imgPath(String imgName) {
  return 'res/imgs/$imgName.png';
}
