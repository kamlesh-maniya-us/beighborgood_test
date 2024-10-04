import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/widget_decorations.dart';

class CommonTextField extends StatelessWidget {
  final bool isEnabled;
  final FocusNode focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int? maxLine;
  const CommonTextField({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.isEnabled = true,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLine = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      keyboardType: keyboardType,
      maxLines: maxLine,
      autocorrect: autoCorrect,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
      cursorRadius: const Radius.circular(4.0),
      textAlignVertical: TextAlignVertical.center,
      decoration: labelOutlineInputDecoration(
        isError: false,
      ).copyWith(
        hintText: hintText,
        // errorStyle: const TextStyle(fontSize: 0.0),
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              overflow: TextOverflow.ellipsis,
              fontSize: 10,
              color: Colors.black.withOpacity(0.5),
            ),
        prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
        suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
