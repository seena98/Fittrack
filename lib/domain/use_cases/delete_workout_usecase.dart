import 'package:fit_track/domain/entities/workouts.dart';

import '../repositories/firebase_repositories.dart';

///delete workout use case is defined here
class DeleteWorkoutUseCase {
  final FirebaseRepository repository;

  DeleteWorkoutUseCase({required this.repository});

  Future<void> call(WorkoutEntity workout) async {
    return repository.deleteWorkout(workout);
  }
}
