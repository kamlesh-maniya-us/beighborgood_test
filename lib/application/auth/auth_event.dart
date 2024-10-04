part of 'auth_bloc.dart';

abstract class AuthEvent {}

class Empty extends AuthEvent {}

class ToggleToSignUp extends AuthEvent {}

class ChangeFullName extends AuthEvent {
  final String name;

  ChangeFullName({required this.name});
}

class ChangeEmailOrNumber extends AuthEvent {
  final String emailOrNumber;

  ChangeEmailOrNumber({required this.emailOrNumber});
}

class ChangePassword extends AuthEvent {
  final String password;

  ChangePassword({required this.password});
}

class ToggleObscureTextState extends AuthEvent {
  final bool isConfirmPassword;

  ToggleObscureTextState({this.isConfirmPassword = false});
}

class ToggleRememberMeState extends AuthEvent {}

class ToggleAgreeTermsState extends AuthEvent {}

class CreateUserWithPassword extends AuthEvent {}

class CreateUserWithGoogleSignIn extends AuthEvent {}

class GetSignedUser extends AuthEvent {}

class SignInWithEmailAndPassword extends AuthEvent {}
