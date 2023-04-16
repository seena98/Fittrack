import 'package:fit_track/domain/entities/user_entity.dart';
import 'package:fit_track/domain/entities/workouts.dart';

import '../../domain/repositories/firebase_repositories.dart';
import '../remote/data_sources/firebase_remote_data_source.dart';

///this class implements all the firebase functions and sends theme to remote data source
class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addWorkout(WorkoutEntity workout) async =>
      remoteDataSource.addWorkout(workout);

  @override
  Future<void> deleteWorkout(WorkoutEntity workout) async =>
      remoteDataSource.deleteWorkout(workout);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Stream<List<WorkoutEntity>> getWorkouts(String uid) =>
      remoteDataSource.getWorkouts(uid);

  @override
  Future<bool> isSignedIn() async => remoteDataSource.isSignedIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateWorkout(WorkoutEntity workout) async =>
      remoteDataSource.updateWorkout(workout);
}
