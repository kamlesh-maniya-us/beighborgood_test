import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/domain/_core/auth_failure.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/users.dart';

import '../../domain/auth/i_auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;
  AuthBloc(
    this._authFacade,
  ) : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case ToggleToSignUp e:
          await _onToggleToSignUp(e, emit);
          break;
        case ChangeFullName e:
          await _onChangeFullName(e, emit);
          break;
        case ChangeEmailOrNumber e:
          await _onChangeEmailOrNumber(e, emit);
          break;
        case ChangePassword e:
          await _onChangePassword(e, emit);
          break;
        case ToggleObscureTextState e:
          await _onToggleObscureTextState(e, emit);
          break;
        case ToggleRememberMeState e:
          await _onToggleRememberMeState(e, emit);
          break;
        case CreateUserWithGoogleSignIn e:
          await _onCreateUserWithGoogleSignIn(e, emit);
          break;
        case CreateUserWithPassword e:
          await _onCreateUserWithPassword(e, emit);
          break;
        case GetSignedUser e:
          await _onGetSignedUser(e, emit);
          break;
        case SignInWithEmailAndPassword e:
          await _onSignInWithEmailAndPassword(e, emit);
          break;
        case ToggleAgreeTermsState e:
          await _onToggleAgreeTermsState(e, emit);
          break;
        default:
          throw UnimplementedError('Unknown event: $event');
      }
    });
  }

  Future<void> _onToggleToSignUp(ToggleToSignUp e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        isSignInJourney: !state.isSignInJourney,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onChangeFullName(ChangeFullName e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        fullName: e.name,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onChangeEmailOrNumber(ChangeEmailOrNumber e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        emailOrNumber: e.emailOrNumber,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onChangePassword(ChangePassword e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        password: e.password,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onToggleRememberMeState(ToggleRememberMeState e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
        isRememberMeSelected: !state.isRememberMeSelected,
      ),
    );
  }

  Future<void> _onToggleObscureTextState(ToggleObscureTextState e, Emitter<AuthState> emit) async {
    if (e.isConfirmPassword) {
      emit(
        state.copyWith(
          obscureConfirmPasswordText: !state.obscureConfirmPasswordText,
          failureOrSuccess: none(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          obscureText: !state.obscureText,
          failureOrSuccess: none(),
        ),
      );
    }
  }

  Future<void> _onCreateUserWithGoogleSignIn(
      CreateUserWithGoogleSignIn e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
        isValidating: true,
      ),
    );

    final result = await _authFacade.signInWithGoogle();

    final updatedResult = result.fold(
      (l) {
        return state.copyWith(
          failureOrSuccess: optionOf(left(l)),
          isValidating: false,
        );
      },
      (r) {
        return state.copyWith(
          failureOrSuccess: none(),
          isValidating: false,
          isValidated: true,
        );
      },
    );

    emit(updatedResult);
  }

  Future<dynamic> _onCreateUserWithPassword(
      CreateUserWithPassword e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
        isValidating: true,
        isValidated: false,
      ),
    );

    final result = await _authFacade.registerWithEmailAndPassword(
      email: state.emailOrNumber,
      password: state.password,
      name: state.fullName,
    );

    final updatedResult = result.fold(
      (l) {
        return state.copyWith(
          failureOrSuccess: optionOf(left(l)),
          isValidating: false,
        );
      },
      (r) {
        return state.copyWith(
          failureOrSuccess: none(),
          isValidating: false,
          isValidated: true,
        );
      },
    );

    emit(updatedResult);
  }

  Future<void> _onGetSignedUser(GetSignedUser e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
      ),
    );

    final result = await _authFacade.getSignedUser();

    if (result.isSome()) {
      final user = result.fold(() => null, (a) => a);
      currentUser = Users(
        name: user?.displayName ?? "",
        photoURL: user?.photoURL ?? "",
        userId: user?.uid,
      );

      emit(
        state.copyWith(
          failureOrSuccess: none(),
          isValidated: true,
        ),
      );
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPassword e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
        isValidating: true,
        isValidated: false,
      ),
    );

    final result = await _authFacade.signInWithEmailAndPassword(
      email: state.emailOrNumber,
      password: state.password,
    );

    final updatedResult = result.fold(
      (l) {
        return state.copyWith(
          failureOrSuccess: optionOf(left(l)),
          isValidating: false,
        );
      },
      (r) {
        return state.copyWith(
          failureOrSuccess: none(),
          isValidating: false,
          isValidated: true,
        );
      },
    );

    emit(updatedResult);
  }

  Future<void> _onToggleAgreeTermsState(ToggleAgreeTermsState e, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        failureOrSuccess: none(),
        isTermAgreed: !state.isTermAgreed,
      ),
    );
  }
}
