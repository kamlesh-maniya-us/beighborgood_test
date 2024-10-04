import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborgood/application/add_post/add_post_bloc.dart';

import '../../../_core/constant/string_constants.dart';
import '../../_core/widgets/common_text_field.dart';
import '../../auth/widgets/text_field_title_widget.dart';

class DescriptionTextField extends StatefulWidget {
  const DescriptionTextField({super.key});

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
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
          title: StringConstants.description,
        ),
        const SizedBox(height: 8),
        CommonTextField(
          focusNode: _focusNode,
          controller: _controller,
          hintText: StringConstants.writeDescription,
          isEnabled: true,
          keyboardType: TextInputType.multiline,
          maxLine: 5,
          onChanged: (value) {
            context.read<AddPostBloc>().add(ChangeDescription(description: value));
          },
          validator: (value) {
            final input = value ?? "";
            if (input.isEmpty) {
              return StringConstants.descriptionRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
