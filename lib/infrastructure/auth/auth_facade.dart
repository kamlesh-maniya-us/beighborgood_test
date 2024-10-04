import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/users.dart';

import '../../domain/_core/auth_failure.dart';
// import '../../domain/_core/failure.dart' as ;
import '../../domain/auth/i_auth_facade.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _fireStore;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn, this._fireStore);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    if (isConnected) {
      try {
        final result =
            await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

        final userGoogle = _firebaseAuth.currentUser!;

        _fireStore.collection('users').doc(result.user!.uid).set({
          "userId": userGoogle.uid,
          "name": name,
          "email": userGoogle.email ?? "",
          "photoURL": userGoogle.photoURL ?? "",
        });

        currentUser = Users(
          name: name,
          photoURL: "",
          userId: userGoogle.uid,
        );

        return right(unit);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          return left(EmailAlreadyInUse());
        } else {
          return left(ServerError());
        }
      }
    } else {
      return left(SessionExpired());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    if (isConnected) {
      try {
        final result =
            await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

        final userDoc = await _fireStore.collection('users').doc(result.user?.uid).get();

        currentUser = Users.fromMap(jsonDecode(jsonEncode(userDoc.data())));
        return right(unit);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'ERROR_WRONG_PASSWORD' || e.code == 'ERROR_USER_NOT_FOUND') {
          return left(InvalidCredential());
        } else {
          return left(ServerError());
        }
      }
    } else {
      return left(SessionExpired());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    if (isConnected) {
      try {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          return left(CancelledByUser());
        }
        final googleAuthentication = await googleUser.authentication;

        final authCredential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken,
        );

        return _firebaseAuth.signInWithCredential(authCredential).then(
          (value) {
            currentUser = Users(
              name: value.user?.displayName ?? "",
              photoURL: value.user?.photoURL ?? "",
              userId: value.user?.uid,
            );

            _fireStore.collection('users').doc(value.user?.uid).set({
              "userId": value.user?.uid,
              "name": value.user?.displayName ?? "",
              "email": value.user?.email ?? "",
              "photoURL": value.user?.photoURL ?? "",
            });
            return right(unit);
          },
        );
      } on FirebaseAuthException catch (_) {
        return left(ServerError());
      }
    } else {
      return left(SessionExpired());
    }
  }

  @override
  Future<Option<User>> getSignedUser() async {
    return optionOf(_firebaseAuth.currentUser);
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
