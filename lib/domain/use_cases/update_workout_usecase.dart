import 'package:fit_track/domain/entities/workouts.dart';

import '../repositories/firebase_repositories.dart';

class UpdateWorkoutUseCase {
  final FirebaseRepository repository;

  UpdateWorkoutUseCase({required this.repository});

  Future<void> call(WorkoutEntity workout) async {
    return repository.updateWorkout(workout);
  }
}
