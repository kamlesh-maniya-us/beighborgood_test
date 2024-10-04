import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/application/auth/auth_bloc.dart';

import '../../_core/constant/assets.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.icFacebookSvg,
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(CreateUserWithGoogleSignIn());
          },
          child: SvgPicture.asset(
            Assets.icGoogleSvg,
          ),
        ),
        const SizedBox(width: 30),
        SvgPicture.asset(
          Assets.icAppleSvg,
        )
      ],
    );
  }
}
