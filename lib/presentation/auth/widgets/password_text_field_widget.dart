import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../_core/constant/string_constants.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../_core/constant/assets.dart';
import '../../_core/widgets/common_text_field.dart';
import 'text_field_title_widget.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
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
              title: StringConstants.enterPassword,
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
                  context.read<AuthBloc>().add(ToggleObscureTextState());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: SvgPicture.asset(
                    Assets.passwordProtectedSvg,
                  ),
                ),
              ),
              onChanged: (value) {
                context.read<AuthBloc>().add(ChangePassword(password: value));
              },
              obscureText: state.obscureText,
              autoCorrect: false,
              enableSuggestions: false,
              validator: (value) {
                const regex = r"""^[@a-zA-Z0-9_-]+$""";
                final input = value ?? "";
                if (input.isEmpty) {
                  return StringConstants.passwordRequired;
                } else if (input.contains(" ")) {
                  return StringConstants.containsWhiteSpaceError;
                } else if (input.length < 8) {
                  return StringConstants.errorPasswordMinLength;
                } else if (input.length > 45) {
                  return StringConstants.errorPasswordMaxLength;
                } else if (!RegExp(regex).hasMatch(input)) {
                  return StringConstants.passwordValidationError;
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
