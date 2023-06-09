import 'package:fit_track/domain/entities/workouts.dart';

import '../entities/user_entity.dart';

///abstract class for main firebase related functions
abstract class FirebaseRepository {
  Future<bool> isSignedIn();

  Future<void> signIn(UserEntity user);

  Future<void> signUp(UserEntity user);

  Future<void> signOut();

  Future<String> getCurrentUId();

  Future<void> getCreateCurrentUser(UserEntity user);

  Future<void> addWorkout(WorkoutEntity workout);

  Future<void> updateWorkout(WorkoutEntity workout);

  Future<void> deleteWorkout(WorkoutEntity workout);

  Stream<List<WorkoutEntity>> getWorkouts(String uid);
}
