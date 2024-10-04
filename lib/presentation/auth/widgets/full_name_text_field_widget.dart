import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../_core/constant/string_constants.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../_core/widgets/common_text_field.dart';
import 'text_field_title_widget.dart';

class FullNameTextField extends StatefulWidget {
  const FullNameTextField({super.key});

  @override
  State<FullNameTextField> createState() => _FullNameTextFieldState();
}

class _FullNameTextFieldState extends State<FullNameTextField> {
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
          title: StringConstants.fullName,
        ),
        const SizedBox(height: 8),
        CommonTextField(
          focusNode: _focusNode,
          controller: _controller,
          hintText: StringConstants.enterPassword,
          isEnabled: true,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<AuthBloc>().add(ChangeFullName(name: value));
          },
          validator: (value) {
            final input = value ?? "";
            if (input.isEmpty) {
              return StringConstants.nameRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
