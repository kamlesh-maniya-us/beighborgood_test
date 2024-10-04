import 'package:flutter/material.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';

class Utils {
  late BuildContext context;

  Utils(this.context);

  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(
                color: AppTheme.buttonColor,
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    String okBtnText = "Ok",
    String cancelBtnText = "Cancel",
    required Function primaryBtnFunction,
    required Function secondaryBtnFunction,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          actions: [
            GestureDetector(
              onTap: () => primaryBtnFunction(),
              child: Text(okBtnText),
            ),
            GestureDetector(
              onTap: () => secondaryBtnFunction(),
              child: Text(cancelBtnText),
            ),
          ],
        );
      },
    );
  }
}
