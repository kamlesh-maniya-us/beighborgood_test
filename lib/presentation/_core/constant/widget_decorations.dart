import 'package:flutter/material.dart';

import '../../../_core/configs/theme_config.dart';

InputDecoration labelOutlineInputDecoration({
  bool isError = false,
  Color? borderColor,
}) {
  return InputDecoration(
    isDense: true,
    alignLabelWithHint: false,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isError ? AppTheme.redColor : borderColor ?? AppTheme.borderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isError ? AppTheme.redColor : borderColor ?? AppTheme.borderColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isError ? AppTheme.redColor : borderColor ?? AppTheme.borderColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppTheme.redColor,
      ),
    ),
  );
}
