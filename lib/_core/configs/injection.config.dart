// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:neighborgood/application/add_post/add_post_bloc.dart'
    as _i11;
import 'package:neighborgood/application/auth/auth_bloc.dart' as _i12;
import 'package:neighborgood/application/home/home_bloc.dart' as _i15;
import 'package:neighborgood/domain/add_post/i_add_post_repository.dart' as _i9;
import 'package:neighborgood/domain/auth/i_auth_facade.dart' as _i7;
import 'package:neighborgood/domain/home/i_home_repository.dart' as _i13;
import 'package:neighborgood/infrastructure/_core/firebase_injectable_module.dart'
    as _i16;
import 'package:neighborgood/infrastructure/add_post/add_post_repository.dart'
    as _i10;
import 'package:neighborgood/infrastructure/auth/auth_facade.dart' as _i8;
import 'package:neighborgood/infrastructure/home/home_repository.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i3.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i4.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i5.FirebaseFirestore>(
        () => firebaseInjectableModule.firebaseFireStore);
    gh.lazySingleton<_i6.FirebaseStorage>(
        () => firebaseInjectableModule.firebaseStorage);
    gh.lazySingleton<_i7.IAuthFacade>(() => _i8.FirebaseAuthFacade(
          gh<_i4.FirebaseAuth>(),
          gh<_i3.GoogleSignIn>(),
          gh<_i5.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i9.IAddPostRepository>(() => _i10.AddPostRepository(
          gh<_i5.FirebaseFirestore>(),
          gh<_i6.FirebaseStorage>(),
        ));
    gh.factory<_i11.AddPostBloc>(
        () => _i11.AddPostBloc(gh<_i9.IAddPostRepository>()));
    gh.factory<_i12.AuthBloc>(() => _i12.AuthBloc(gh<_i7.IAuthFacade>()));
    gh.lazySingleton<_i13.IHomeRepository>(
        () => _i14.HomeRepository(gh<_i5.FirebaseFirestore>()));
    gh.factory<_i15.HomeBloc>(() => _i15.HomeBloc(gh<_i13.IHomeRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i16.FirebaseInjectableModule {}
