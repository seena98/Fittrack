import 'package:fit_track/domain/entities/workouts.dart';
import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
import 'package:fit_track/presentation/screens/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';

class AddWorkoutScreen extends StatefulWidget {
  static const routeName = "/add-workout-screen";
  final int dayOfWeek;

  const AddWorkoutScreen({required this.dayOfWeek, Key? key}) : super(key: key);

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  TextEditingController trainingTimeTextController = TextEditingController();
  TextEditingController trainingNameTextController = TextEditingController();

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
                        child: const Text(
                          "<  Training Add",
                          style: TextStyle(
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
                    submitWorkout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 10),
                    child: CustomButton(
                        buttonHeight: 44,
                        buttonWidth: width / 2.2,
                        text: "Add"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitWorkout() {
    if (trainingNameTextController.text.isNotEmpty &&
        trainingNameTextController.text.isNotEmpty) {
      BlocProvider.of<WorkoutCubit>(context).addWorkout(
        workout: WorkoutEntity(
          dayOfWeek: widget.dayOfWeek,
          trainingName: trainingNameTextController.text,
          trainingTime: int.parse(trainingTimeTextController.text),
          id: "",
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }
}
