import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/workouts.dart';

///workout model extending workout entity to handle json serialization
class WorkoutModel extends WorkoutEntity {
  const WorkoutModel({
    final String? id,
    final String? trainingName,
    final int? trainingTime,
    final int? dayOfWeek,
  }) : super(
          dayOfWeek: dayOfWeek,
          id: id,
          trainingName: trainingName,
          trainingTime: trainingTime,
        );

  ///translated data from db into objects
  factory WorkoutModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return WorkoutModel(
      id: documentSnapshot.get("id"),
      dayOfWeek: documentSnapshot.get("dayOfWeek"),
      trainingName: documentSnapshot.get("trainingName"),
      trainingTime: documentSnapshot.get("trainingTime"),
    );
  }

  ///translates object into data ready to send to db
  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "dayOfWeek": dayOfWeek,
      "trainingName": trainingName,
      "trainingTime": trainingTime,
    };
  }
}
