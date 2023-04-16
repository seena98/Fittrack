import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/data/remote/models/workout_model.dart';
import 'package:fit_track/domain/entities/workouts.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/user_entity.dart';
import '../models/user_model.dart';
import 'firebase_remote_data_source.dart';

///this class implements all the firebase functions
class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  static const String workoutCollectionName = "workouts";
  static const String userCollectionName = "users";

  ///this function gets a Workout Entity and translates it into document on saves it on firebase db
  @override
  Future<void> addWorkout(WorkoutEntity workoutEntity) async {
    debugPrint('started');

    ///generating id for document
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(await getCurrentUId())
        .collection("workouts");

    ///fetching id for saving data
    final workoutId = workoutCollectionRef.doc().id;

    ///saving workout on servers
    workoutCollectionRef.doc(workoutId).get().then((workout) {
      final newWorkout = WorkoutModel(
        id: workoutId,
        trainingTime: workoutEntity.trainingTime,
        trainingName: workoutEntity.trainingName,
        dayOfWeek: workoutEntity.dayOfWeek,
      ).toDocument();

      if (!workout.exists) {
        workoutCollectionRef.doc(workoutId).set(newWorkout);
      }
      return;
    });
  }

  ///this function gets a workout entity and then deletes it's related data on servers
  @override
  Future<void> deleteWorkout(WorkoutEntity workoutEntity) async {
    ///finding related workout
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(await getCurrentUId())
        .collection(workoutCollectionName);

    ///delete the related workout
    workoutCollectionRef.doc(workoutEntity.id).get().then((workout) {
      if (workout.exists) {
        workoutCollectionRef.doc(workoutEntity.id).delete();
      }
      return;
    });
  }

  ///this function sets the user data it does not exist on db
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection(userCollectionName);
    final uid = await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      } else {}
      return;
    });
  }

  ///fetch user id
  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  ///this is a stream of workouts this stream keep workouts always updated
  @override
  Stream<List<WorkoutEntity>> getWorkouts(String id) {
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(workoutCollectionName);
    return workoutCollectionRef.snapshots().map((querySnap) {
      debugPrint(querySnap.docs.toString());
      return querySnap.docs
          .map((docSnap) => WorkoutModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  ///this function checks if the user is signed in or not
  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  ///this functions signs the user into the app
  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  ///this function signs the user out of the app
  @override
  Future<void> signOut() async => auth.signOut();

  ///this functions registers the user's new account
  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  ///this function fetches a workout entity and updates it on firebase db
  @override
  Future<void> updateWorkout(WorkoutEntity workout) async {
    debugPrint("started update");
    Map<String, dynamic> workoutMap = {};

    ///find the related workout
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(await getCurrentUId())
        .collection(workoutCollectionName);

    ///update it's values
    if (workout.trainingName != null) {
      workoutMap['trainingName'] = workout.trainingName;
    }
    if (workout.trainingTime != null) {
      workoutMap['trainingTime'] = workout.trainingTime;
    }

    ///update the workout on db
    workoutCollectionRef.doc(workout.id).update(workoutMap);
  }
}
