part of 'workout_cubit.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();
}

class WorkoutInitial extends WorkoutState {
  @override
  List<Object> get props => [];
}

class WorkoutLoading extends WorkoutState {
  @override
  List<Object> get props => [];
}

class WorkoutFailure extends WorkoutState {
  @override
  List<Object> get props => [];
}

class WorkoutLoaded extends WorkoutState {
  final List<WorkoutEntity> workouts;

  const WorkoutLoaded({required this.workouts});

  @override
  List<Object> get props => [workouts];
}
