import 'package:fit_track/domain/entities/workouts.dart';

import '../repositories/firebase_repositories.dart';

///get workout use case is defined here
class GetWorkoutsUseCase {
  final FirebaseRepository repository;

  GetWorkoutsUseCase({required this.repository});

  Stream<List<WorkoutEntity>> call(String uid) {
    return repository.getWorkouts(uid);
  }
}
