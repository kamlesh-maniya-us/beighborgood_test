import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';
import 'package:neighborgood/presentation/_core/widgets/custom_toast.dart';
import 'package:sizer/sizer.dart';

class PrimaryButton extends StatelessWidget {
  final bool isDisabled;
  final bool isProgressing;
  final String btnText;
  final VoidCallback? onPressed;
  final EdgeInsets contentPadding;
  final Color? textColor;
  final BorderSide? borderSide;
  final Widget? loader;

  const PrimaryButton({
    super.key,
    this.isDisabled = false,
    this.isProgressing = false,
    required this.btnText,
    required this.onPressed,
    this.contentPadding = const EdgeInsets.all(2),
    this.textColor,
    this.borderSide,
    this.loader,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextButton(
        onPressed: isDisabled
            ? null
            : isProgressing
                ? () {
                    CustomToast.show(
                      title: StringConstants.processing,
                    );
                  }
                : onPressed,
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              side: MaterialStateProperty.all(borderSide),
              padding: contentPadding.wrapMatProp(),
              foregroundColor: AppTheme.buttonColor.wrapMatProp(),
              // isDisabled ? AppTheme.grey2.wrapMatProp() : buttonColor.wrapMatProp(),
              backgroundColor: AppTheme.buttonColor.wrapMatProp(),
              minimumSize: Size(100.w, 56.0).wrapMatProp(),
            ),
        child: isProgressing
            ? loader ??
                const CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      btnText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

extension MaterialPropX<T> on T {
  MaterialStateProperty<T> wrapMatProp() => MaterialStateProperty.resolveWith<T>((states) => this);
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final String asset;
  final VoidCallback onTap;
  const SecondaryButton({super.key, required this.title, required this.asset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.secondaryButtonColor, // Button color
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                  ),
            )
          ],
        )),
      ),
    );
  }
}
