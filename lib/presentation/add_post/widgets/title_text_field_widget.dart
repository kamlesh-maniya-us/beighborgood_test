import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborgood/application/add_post/add_post_bloc.dart';

import '../../../_core/constant/string_constants.dart';
import '../../_core/widgets/common_text_field.dart';
import '../../auth/widgets/text_field_title_widget.dart';

class TitleTextField extends StatefulWidget {
  const TitleTextField({super.key});

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
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
          title: StringConstants.eventTitle,
        ),
        const SizedBox(height: 8),
        CommonTextField(
          focusNode: _focusNode,
          controller: _controller,
          hintText: StringConstants.postTitle,
          isEnabled: true,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<AddPostBloc>().add(ChangeTitle(title: value));
          },
          validator: (value) {
            final input = value ?? "";
            if (input.isEmpty) {
              return StringConstants.titleRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
