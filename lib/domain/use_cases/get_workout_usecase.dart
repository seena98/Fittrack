import 'package:fit_track/domain/entities/workouts.dart';

import '../repositories/firebase_repositories.dart';

class GetWorkoutsUseCase {
  final FirebaseRepository repository;

  GetWorkoutsUseCase({required this.repository});

  Future<List<WorkoutEntity>> call(String uid) {
    return repository.getWorkouts(uid);
  }
}
