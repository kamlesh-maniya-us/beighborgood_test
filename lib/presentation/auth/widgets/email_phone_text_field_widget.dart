import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';
import 'package:neighborgood/application/auth/auth_bloc.dart';
import 'package:neighborgood/presentation/_core/widgets/common_text_field.dart';

import '../../_core/constant/assets.dart';
import 'text_field_title_widget.dart';

class EmailOrPhoneTextField extends StatefulWidget {
  const EmailOrPhoneTextField({super.key});

  @override
  State<EmailOrPhoneTextField> createState() => _EmailOrPhoneTextFieldState();
}

class _EmailOrPhoneTextFieldState extends State<EmailOrPhoneTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldTitle(
          title: StringConstants.emailOrPhone,
        ),
        const SizedBox(height: 8),
        CommonTextField(
          focusNode: _focusNode,
          controller: _controller,
          hintText: StringConstants.emailOrPhone,
          isEnabled: true,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 6),
            child: SvgPicture.asset(
              Assets.emailSvg,
            ),
          ),
          onChanged: (value) {
            context.read<AuthBloc>().add(ChangeEmailOrNumber(emailOrNumber: value));
          },
          validator: (value) {
            final input = value ?? "";
            const regex =
                r"""^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$""";
            if (input.isEmpty) {
              return StringConstants.emailOrPhoneRequired;
            } else if (isNumeric(input) && input.length < 10) {
              return StringConstants.mobileNumberShortError;
            } else if (input.contains(" ")) {
              return StringConstants.containsWhiteSpaceError;
            } else if (!RegExp(regex).hasMatch(input) && !isNumeric(input)) {
              return StringConstants.enterValidEmail;
            }
            return null;
          },
        ),
      ],
    );
  }
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
