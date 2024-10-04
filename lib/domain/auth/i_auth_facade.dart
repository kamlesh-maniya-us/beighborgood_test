import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../_core/auth_failure.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedUser();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();

  
}
