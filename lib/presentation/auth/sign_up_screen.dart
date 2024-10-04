import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/_core/configs/injection.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';
import 'package:neighborgood/application/auth/auth_bloc.dart';
import 'package:neighborgood/domain/_core/auth_failure.dart';
import 'package:neighborgood/presentation/_core/constant/assets.dart';
import 'package:neighborgood/presentation/_core/constant/utils.dart';
import 'package:neighborgood/presentation/_core/widgets/buttons.dart';
import 'package:neighborgood/presentation/_core/widgets/custom_toast.dart';
import 'package:neighborgood/presentation/auth/widgets/confirm_password_text_field_widget.dart';
import 'package:neighborgood/presentation/auth/widgets/forgot_password_widget.dart';
import 'package:neighborgood/presentation/auth/widgets/full_name_text_field_widget.dart';
import 'package:neighborgood/presentation/auth/widgets/password_text_field_widget.dart';
import 'package:neighborgood/presentation/auth/widgets/social_login_widget.dart';
import 'package:neighborgood/presentation/_core/router/route_names.dart';
import 'package:sizer/sizer.dart';

import 'widgets/email_phone_text_field_widget.dart';
import 'widgets/remember_me_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(GetSignedUser()),
      child: const SignUpScreenUI(),
    );
  }
}

class SignUpScreenUI extends StatefulWidget {
  const SignUpScreenUI({super.key});

  @override
  State<SignUpScreenUI> createState() => _SignUpScreenUIState();
}

class _SignUpScreenUIState extends State<SignUpScreenUI> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.failureOrSuccess.fold(
          () => null,
          (a) => a.fold(
            (l) {
              switch (l) {
                case CancelledByUser():
                  CustomToast.show(title: StringConstants.cancelledByUser);
                  break;
                case InvalidCredential():
                  CustomToast.show(title: StringConstants.pleaseEnterCorrectEmail);
                  break;
                case AccountExistWithDifferentCredential():
                  CustomToast.show(title: StringConstants.accountAlreadyExist);
                  break;
                case EmailAlreadyInUse():
                  CustomToast.show(title: StringConstants.emailAlreadyExist);
                  break;
                case SessionExpired():
                  CustomToast.show(title: StringConstants.noInternetError);
                  break;
                case ServerError():
                  CustomToast.show(title: StringConstants.serverError);
                  break;
              }
            },
            (r) => null,
          ),
        );
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.isValidating,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppBar().preferredSize.height,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 54),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.logoSvg,
                              height: 7.h,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              if (state.isSignInJourney) ...[
                                Text(
                                  StringConstants.welcomeBack,
                                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  StringConstants.letsLogin,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: Colors.black.withOpacity(0.50),
                                      ),
                                ),
                                const SizedBox(height: 36),
                              ] else ...[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    StringConstants.createAccount,
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const FullNameTextField(),
                                const SizedBox(height: 16),
                              ],
                              const EmailOrPhoneTextField(),
                              const SizedBox(height: 18),
                              const PasswordTextField(),
                              if (!state.isSignInJourney) ...[
                                const SizedBox(height: 16),
                                const ConfirmPasswordTextField(),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (!state.isSignInJourney) ...[
                          const SizedBox(height: 16),
                          CustomCheckBoxWithTitle(
                            isChecked: state.isTermAgreed,
                            onTap: () {
                              context.read<AuthBloc>().add(ToggleAgreeTermsState());
                            },
                            title: StringConstants.agreeTermsNCondition,
                          ),
                        ] else ...[
                          const ForgotPassword(),
                          CustomCheckBoxWithTitle(
                            isChecked: state.isRememberMeSelected,
                            onTap: () {
                              context.read<AuthBloc>().add(ToggleRememberMeState());
                            },
                            title: StringConstants.rememberMe,
                          ),
                        ],
                        const SizedBox(height: 26),
                        BlocListener<AuthBloc, AuthState>(
                          listenWhen: (previous, current) =>
                              previous.isValidating != current.isValidating ||
                              previous.isValidated != current.isValidated,
                          listener: (context, state) {
                            if (state.isValidating) {
                              Utils(context).startLoading();
                            } else {
                              Utils(context).stopLoading();
                            }

                            if (state.isValidated) {
                              mainNavigator.navigateTo(AllRoutes.homeRoute, isReplace: true);
                            }
                          },
                          child: PrimaryButton(
                            btnText: state.isSignInJourney
                                ? StringConstants.signIn
                                : StringConstants.createAccount,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (!state.isSignInJourney && !state.isTermAgreed) {
                                  CustomToast.show(title: StringConstants.pleaseAgreeTerms);
                                  return;
                                }

                                if (state.isSignInJourney) {
                                  context.read<AuthBloc>().add(SignInWithEmailAndPassword());
                                } else {
                                  context.read<AuthBloc>().add(CreateUserWithPassword());
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                endIndent: 8,
                                indent: 14,
                                color: AppTheme.borderColor,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              StringConstants.connectWith,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF000000),
                                  ),
                            ),
                            const Expanded(
                              child: Divider(
                                indent: 8,
                                endIndent: 14,
                                color: AppTheme.borderColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        const SocialLogin(),
                        const SizedBox(height: 30),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: StringConstants.dontHaveAccount,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              TextSpan(
                                text: state.isSignInJourney
                                    ? StringConstants.signUpHere
                                    : StringConstants.login,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppTheme.buttonColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<AuthBloc>().add(ToggleToSignUp());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
