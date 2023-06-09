import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/remote/models/user_model.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';
import '../../../domain/use_cases/sign_up_usecase.dart';

part 'user_state.dart';

///this cubit is responsible for user sign in / up functionalities
class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUPUseCase signUPUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  UserEntity? userData;

  UserCubit({required this.signUPUseCase,
    required this.signInUseCase,
    required this.getCreateCurrentUserUseCase})
      : super(UserInitial());

  ///sing the user in with email and password
  Future<void> submitSignIn({required UserEntity user}) async {
    debugPrint("started");
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      //fetch users data from db
      final userCollectionRef =
      FirebaseFirestore.instance.collection("users");
      userCollectionRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        final newUser = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: value.data()!["email"],
          name: value.data()!["name"],
        );
        debugPrint("name: ${value.data()!["name"]}");
        //set our users data on memory
        userData = newUser;
      });
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }


  ///this function signs the user up
  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      debugPrint("started");
      await signUPUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      //set user data on memory after sign up
      userData = user;
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
