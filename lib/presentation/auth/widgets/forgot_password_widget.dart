import 'package:flutter/material.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          StringConstants.forgotPassword,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.buttonColor,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.buttonColor,
              ),
        )
      ],
    );
  }
}
