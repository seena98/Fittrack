part of 'workout_cubit.dart';

///workout state for workout bloc is defined here with every type of state related to it
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

///this state also contains the list of workouts
class WorkoutLoaded extends WorkoutState {
  final List<WorkoutEntity> workouts;

  const WorkoutLoaded({required this.workouts});

  @override
  List<Object> get props => [workouts];
}
