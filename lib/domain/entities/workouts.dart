import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [id, trainingName, trainingTime, dayOfWeek];
}
