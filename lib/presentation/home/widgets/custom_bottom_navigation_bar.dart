import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/presentation/_core/constant/assets.dart';
import 'package:neighborgood/presentation/home/widgets/custom_image.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentSelected;
  final ValueChanged<int> onChange;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentSelected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 50.0,
            offset: const Offset(0.0, -5),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: currentSelected,
          onTap: onChange,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentSelected == 0 ? Assets.icHomeSelectedSvg : Assets.icHomeSvg,
                height: 24,
                width: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentSelected == 1 ? Assets.icSearchSelectedSvg : Assets.icSearchSvg,
                height: 24,
                width: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentSelected == 2 ? Assets.icAddPostSelectedSvg : Assets.icAddPostSvg,
                height: 24,
                width: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentSelected == 3 ? Assets.icChatSelectedSvg : Assets.icChatSvg,
                height: 24,
                width: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    border: currentSelected == 4
                        ? Border.all(
                            color: AppTheme.buttonColor,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(36)),
                height: 24,
                width: 24,
                child: CustomImage(imageUrl: currentUser.photoURL),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
