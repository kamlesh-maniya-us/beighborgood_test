import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final String count;
  final String subTitle;
  const ProfileStats({
    super.key,
    required this.count,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 10,
                color: Colors.black.withOpacity(0.5),
              ),
        ),
      ],
    );
  }
}
