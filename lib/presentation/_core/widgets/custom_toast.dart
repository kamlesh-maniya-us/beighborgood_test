import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../_core/configs/theme_config.dart';

class CustomToast {
  static void show({required String title}) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.buttonColor,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
}
