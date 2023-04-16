import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/domain/use_cases/add_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/delete_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:fit_track/domain/use_cases/get_current_uid_usecase.dart';
import 'package:fit_track/domain/use_cases/get_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/update_workout_usecase.dart';
import 'package:fit_track/presentation/bloc/auth/auth_cubit.dart';
import 'package:fit_track/presentation/bloc/user/user_cubit.dart';
import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/remote/data_sources/firebase_remote_data_source.dart';
import 'data/remote/data_sources/firebase_remote_data_source_imp.dart';
import 'data/repositories/firebase_repository_imp.dart';
import 'domain/repositories/firebase_repositories.dart';
import 'domain/use_cases/is_sign_in_usecase.dart';
import 'domain/use_cases/sign_in_usecase.dart';
import 'domain/use_cases/sign_out_usecase.dart';
import 'domain/use_cases/sign_up_usecase.dart';

GetIt getItHandler = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  getItHandler.registerFactory<AuthCubit>(() => AuthCubit(
      isSignedInUseCase: getItHandler.call(),
      signOutUseCase: getItHandler.call(),
      getCurrentUidUseCase: getItHandler.call()));
  getItHandler.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: getItHandler.call(),
        signInUseCase: getItHandler.call(),
        signUPUseCase: getItHandler.call(),
      ));
  getItHandler.registerFactory<WorkoutCubit>(() => WorkoutCubit(
        updateWorkoutUseCase: getItHandler.call(),
        getWorkoutsUseCase: getItHandler.call(),
        deleteWorkoutUseCase: getItHandler.call(),
        addWorkoutUseCase: getItHandler.call(),
      ));
  //useCase
  getItHandler.registerLazySingleton<AddWorkoutUseCase>(
      () => AddWorkoutUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<DeleteWorkoutUseCase>(
      () => DeleteWorkoutUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<UpdateWorkoutUseCase>(
      () => UpdateWorkoutUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<GetWorkoutsUseCase>(
      () => GetWorkoutsUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<IsSignedInUseCase>(
      () => IsSignedInUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: getItHandler.call()));
  getItHandler.registerLazySingleton<SignUPUseCase>(
      () => SignUPUseCase(repository: getItHandler.call()));

  //repository
  getItHandler.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: getItHandler.call()));

  //data source
  getItHandler.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          auth: getItHandler.call(), firestore: getItHandler.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  getItHandler.registerLazySingleton(() => auth);
  getItHandler.registerLazySingleton(() => fireStore);
}
