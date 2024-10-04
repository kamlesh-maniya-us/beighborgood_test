import 'package:flutter/material.dart';

import '../../../_core/configs/theme_config.dart';
import '../../../_core/constant/string_constants.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  const TextFieldTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
          ),
          TextSpan(
            text: StringConstants.asterisk,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.redColor,
                ),
          ),
        ],
      ),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(),
    );
  }
}
