import 'package:fit_track/domain/entities/workouts.dart';

import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();

  Future<void> signIn(UserEntity user);

  Future<void> signUp(UserEntity user);

  Future<void> signOut();

  Future<String> getCurrentUId();

  Future<void> getCreateCurrentUser(UserEntity user);

  Future<void> addWorkout(WorkoutEntity workout);

  Future<void> updateWorkout(WorkoutEntity workout);

  Future<void> deleteWorkout(WorkoutEntity workout);

  Future<List<WorkoutEntity>> getWorkouts(String uid);
}
