import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/get_current_uid_usecase.dart';
import '../../../domain/use_cases/is_sign_in_usecase.dart';
import '../../../domain/use_cases/sign_out_usecase.dart';

part 'auth_state.dart';

///this cubit is responsible for checking user auth state in splash and also change user auth state through sign out
class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(
      {required this.isSignedInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUidUseCase})
      : super(AuthInitial());

  ///this function is ran on app start in splash screen
  Future<void> appStarted() async {
    //this delay has been set to show the user our splash screen
    await Future.delayed(const Duration(seconds: 1));
    try {
      final isSignIn = await isSignedInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  ///this functions signs the user out of the app
  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
