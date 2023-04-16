import 'package:equatable/equatable.dart';

///this is a workout model
class WorkoutEntity extends Equatable {
  final String? id;
  final String? trainingName;
  final int? trainingTime;
  final int? dayOfWeek;

  const WorkoutEntity({
    required this.id,
    required this.dayOfWeek,
    required this.trainingTime,
    required this.trainingName,
  });

  ///props are used for Equatable functions
  @override
  List<Object?> get props => [id, trainingName, trainingTime, dayOfWeek];
}
