import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_track/domain/entities/workouts.dart';
import 'package:fit_track/domain/use_cases/add_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/delete_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/get_workout_usecase.dart';
import 'package:fit_track/domain/use_cases/update_workout_usecase.dart';

part 'workout_state.dart';

///this cubit is responsible for adding, updating, deleting and fetching  workouts
class WorkoutCubit extends Cubit<WorkoutState> {
  final UpdateWorkoutUseCase updateWorkoutUseCase;
  final DeleteWorkoutUseCase deleteWorkoutUseCase;
  final GetWorkoutsUseCase getWorkoutsUseCase;
  final AddWorkoutUseCase addWorkoutUseCase;

  WorkoutCubit({
    required this.getWorkoutsUseCase,
    required this.deleteWorkoutUseCase,
    required this.updateWorkoutUseCase,
    required this.addWorkoutUseCase,
  }) : super(WorkoutInitial());


  ///this functions gets a workout entity and adds it into db
  Future<void> addWorkout({required WorkoutEntity workout}) async {
    try {
      ///call functionality from use cases
      await addWorkoutUseCase.call(workout);
    } on SocketException catch (_) {
      emit(WorkoutFailure());
    } catch (_) {
      emit(WorkoutFailure());
    }
  }

  ///this functions gets a workout entity and deletes it from the db
  Future<void> deleteWorkout({required WorkoutEntity workout}) async {
    try {
      ///call functionality from use cases
      await deleteWorkoutUseCase.call(workout);
    } on SocketException catch (_) {
      emit(WorkoutFailure());
    } catch (_) {
      emit(WorkoutFailure());
    }
  }

  ///this functions gets a workout entity and updates it on db
  Future<void> updateWorkout({required WorkoutEntity workout}) async {
    try {
      await updateWorkoutUseCase.call(workout);
    } on SocketException catch (_) {
      emit(WorkoutFailure());
    } catch (_) {
      emit(WorkoutFailure());
    }
  }

  ///this functions fetches all of user workouts
  Future<void> getWorkouts({required String uid}) async {
    emit(WorkoutLoading());
    try {
      getWorkoutsUseCase.call(uid).listen((workout) {
        emit(WorkoutLoaded(workouts: workout));
      });
    } on SocketException catch (_) {
      emit(WorkoutFailure());
    } catch (_) {
      emit(WorkoutFailure());
    }
  }
}
