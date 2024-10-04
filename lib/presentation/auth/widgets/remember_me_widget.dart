import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/presentation/_core/constant/assets.dart';

class CustomCheckBoxWithTitle extends StatelessWidget {
  final String title;
  final bool isChecked;
  final VoidCallback onTap;
  const CustomCheckBoxWithTitle({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isChecked ? Assets.checkBoxCheckedSvg : Assets.checkBoxUncheckedSvg,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 16,
            width: 16,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
