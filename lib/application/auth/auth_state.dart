part of 'auth_bloc.dart';

class AuthState {
  final bool isSignInJourney;
  final String fullName;
  final String password;
  final String emailOrNumber;
  final bool obscureText;
  final bool obscureConfirmPasswordText;
  final Option<Either<AuthFailure, Unit>> failureOrSuccess;
  final bool isValidating;
  final bool isValidated;
  final bool isRememberMeSelected;
  final bool isTermAgreed;

  AuthState({
    required this.fullName,
    required this.password,
    required this.emailOrNumber,
    required this.failureOrSuccess,
    required this.isSignInJourney,
    required this.obscureText,
    required this.obscureConfirmPasswordText,
    required this.isRememberMeSelected,
    required this.isValidating,
    required this.isValidated,
    required this.isTermAgreed,
  });

  factory AuthState.initial() => AuthState(
        failureOrSuccess: none(),
        isSignInJourney: true,
        fullName: '',
        password: '',
        emailOrNumber: '',
        obscureText: true,
        isRememberMeSelected: false,
        obscureConfirmPasswordText: true,
        isValidating: false,
        isValidated: false,
        isTermAgreed: false,
      );

  AuthState copyWith({
    Option<Either<AuthFailure, Unit>>? failureOrSuccess,
    bool? isSignInJourney,
    String? fullName,
    String? password,
    String? emailOrNumber,
    bool? obscureText,
    bool? isRememberMeSelected,
    bool? obscureConfirmPasswordText,
    bool? isValidating,
    bool? isValidated,
    bool? isTermAgreed,
  }) {
    return AuthState(
      failureOrSuccess: failureOrSuccess ?? this.failureOrSuccess,
      isSignInJourney: isSignInJourney ?? this.isSignInJourney,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      emailOrNumber: emailOrNumber ?? this.emailOrNumber,
      obscureText: obscureText ?? this.obscureText,
      isRememberMeSelected: isRememberMeSelected ?? this.isRememberMeSelected,
      obscureConfirmPasswordText: obscureConfirmPasswordText ?? this.obscureConfirmPasswordText,
      isValidating: isValidating ?? this.isValidating,
      isValidated: isValidated ?? this.isValidated,
      isTermAgreed: isTermAgreed ?? this.isTermAgreed,
    );
  }
}
