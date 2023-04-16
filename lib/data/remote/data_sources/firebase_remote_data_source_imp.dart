import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/data/remote/models/workout_model.dart';
import 'package:fit_track/domain/entities/workouts.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/user_entity.dart';
import '../models/user_model.dart';
import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  static const String workoutCollectionName = "workouts";
  static const String userCollectionName = "users";

  @override
  Future<void> addWorkout(WorkoutEntity workoutEntity) async {
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(await getCurrentUId())
        .collection("workouts");

    final workoutId = workoutCollectionRef.doc().id;

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

  @override
  Future<void> deleteWorkout(WorkoutEntity workoutEntity) async {
    final workoutCollectionRef = firestore
        .collection("users")
        .doc(await getCurrentUId())
        .collection(workoutCollectionName);

    workoutCollectionRef.doc(workoutEntity.id).get().then((workout) {
      if (workout.exists) {
        workoutCollectionRef.doc(workoutEntity.id).delete();
      }
      return;
    });
  }

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

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

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

  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateWorkout(WorkoutEntity workout) async {
    Map<String, dynamic> workoutMap = {};
    final workoutCollectionRef = firestore
        .collection(userCollectionName)
        .doc(await getCurrentUId())
        .collection(workoutCollectionName);

    if (workout.trainingName != null) {
      workoutMap['trainingName'] = workout.trainingName;
    }
    if (workout.trainingTime != null) {
      workoutMap['trainingTime'] = workout.trainingTime;
    }

    workoutCollectionRef.doc(workout.id).update(workoutMap);
  }
}
