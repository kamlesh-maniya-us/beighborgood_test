import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../_core/constant/string_constants.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../_core/constant/assets.dart';
import '../../_core/widgets/common_text_field.dart';
import 'text_field_title_widget.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFieldTitle(
              title: StringConstants.confirmPassword,
            ),
            const SizedBox(height: 8),
            CommonTextField(
              focusNode: _focusNode,
              controller: _controller,
              hintText: StringConstants.enterPassword,
              isEnabled: true,
              keyboardType: TextInputType.text,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 6),
                child: SvgPicture.asset(
                  Assets.lockSvg,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(
                        ToggleObscureTextState(isConfirmPassword: true),
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: SvgPicture.asset(
                    Assets.passwordProtectedSvg,
                  ),
                ),
              ),
              obscureText: state.obscureConfirmPasswordText,
              autoCorrect: false,
              enableSuggestions: false,
              onChanged: (_) {},
              validator: (value) {
                final input = value ?? "";
                if (input.isEmpty) {
                  return StringConstants.errorEnterPassword;
                } else if (state.password != input) {
                  return StringConstants.passwordMustBeSame;
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
