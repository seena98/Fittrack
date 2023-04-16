import 'package:fit_track/domain/entities/workouts.dart';

import '../repositories/firebase_repositories.dart';

class AddWorkoutUseCase {
  final FirebaseRepository repository;

  AddWorkoutUseCase({required this.repository});

  Future<void> call(WorkoutEntity workout) async {
    return repository.addWorkout(workout);
  }
}
