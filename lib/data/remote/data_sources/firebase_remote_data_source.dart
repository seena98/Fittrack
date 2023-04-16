import '../../../domain/entities/user_entity.dart';
import '../../../domain/entities/workouts.dart';

abstract class FirebaseRemoteDataSource {
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
