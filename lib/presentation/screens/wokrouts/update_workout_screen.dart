import 'package:fit_track/domain/entities/workouts.dart';
import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../global_widgets/custom_button.dart';

class UpdateWorkoutScreen extends StatefulWidget {
  final int dayOfWeek;
  final String trainingName;
  final int trainingTime;
  final String id;

  const UpdateWorkoutScreen({
    required this.dayOfWeek,
    required this.trainingName,
    required this.trainingTime,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateWorkoutScreen> createState() => _UpdateWorkoutScreenState();
}

class _UpdateWorkoutScreenState extends State<UpdateWorkoutScreen> {
  TextEditingController trainingTimeTextController = TextEditingController();
  TextEditingController trainingNameTextController = TextEditingController();

  @override
  void initState() {
    trainingTimeTextController.text = widget.trainingTime.toString();
    trainingNameTextController.text = widget.trainingName;
    super.initState();
  }

  @override
  void dispose() {
    trainingTimeTextController.dispose();
    trainingNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var width = MediaQuery.of(context).size.shortestSide;
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: height / 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSecondary,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "<  ${widget.trainingName}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                        },
                        child: Image.asset(
                          height: 28,
                          "assets/icons/power.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
                child: Text(
                  "Add the workout of your choice.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: TextField(
                  controller: trainingNameTextController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(hintText: "Training name"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: TextField(
                  controller: trainingTimeTextController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Training time",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    updateWorkout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 10),
                    child: CustomButton(
                        buttonHeight: 44,
                        buttonWidth: width / 2.2,
                        text: "Update"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateWorkout() {
    BlocProvider.of<WorkoutCubit>(context).updateWorkout(
      workout: WorkoutEntity(
        trainingTime: int.parse(trainingTimeTextController.text),
        trainingName: trainingNameTextController.text,
        dayOfWeek: widget.dayOfWeek,
        id: widget.id,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
