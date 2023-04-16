import 'package:fit_track/presentation/bloc/user/user_cubit.dart';
import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
import 'package:fit_track/presentation/screens/wokrouts/add_workout_screen.dart';
import 'package:fit_track/presentation/screens/wokrouts/widgets/data_choose_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';

class ExploreWorkoutsScreen extends StatefulWidget {
  const ExploreWorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<ExploreWorkoutsScreen> createState() => _ExploreWorkoutsScreenState();
}

class _ExploreWorkoutsScreenState extends State<ExploreWorkoutsScreen> {
  @override
  void initState() {
    BlocProvider.of<WorkoutCubit>(context).getWorkouts(uid: "");
    super.initState();
  }

  bool isSelected = false;
  int dayOfWeek = 0;
  var workouts = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: isSelected
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddWorkoutScreen(
                      dayOfWeek: dayOfWeek,
                    ),
                  ),
                );
              },
              backgroundColor: theme.colorScheme.onSecondary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, workoutState) {
              if (workoutState is WorkoutLoaded) {
                WorkoutLoaded loadedState = workoutState;
                debugPrint(
                    "loadedState length: ${loadedState.workouts.length}");
                return Column(
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
                                setState(() {
                                  isSelected = false;
                                });
                              },
                              child: Text(
                                isSelected ? "<  Workouts" : "<  Days",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Hello,${BlocProvider.of<UserCubit>(context, listen: false).userData?.name ?? ""}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 5),
                      child: Text(
                        isSelected
                            ? "Select the workout you want to change"
                            : "Choose the day you want to make reservations",
                        style: const TextStyle(
                          color: Color(0xffA1A1A1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (!isSelected) ...[
                      InkWell(
                          onTap: () {
                            setState(() {
                              dayOfWeek = 0;
                              isSelected = true;
                            });
                          },
                          child:
                              const DataChooseBox(height: 50, text: "Monday")),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 1;
                            isSelected = true;
                          });
                        },
                        child: const DataChooseBox(height: 50, text: "Tuesday"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 2;
                            isSelected = true;
                          });
                        },
                        child:
                            const DataChooseBox(height: 50, text: "Wednesday"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 3;
                            isSelected = true;
                          });
                        },
                        child:
                            const DataChooseBox(height: 50, text: "Thursday"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 4;
                            isSelected = true;
                          });
                        },
                        child: const DataChooseBox(height: 50, text: "Friday"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 5;
                            isSelected = true;
                          });
                        },
                        child:
                            const DataChooseBox(height: 50, text: "Saturday"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dayOfWeek = 6;
                            isSelected = true;
                          });
                        },
                        child: const DataChooseBox(height: 50, text: "Sunday"),
                      ),
                    ],
                    if (isSelected) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: loadedState.workouts
                            .where((element) => element.dayOfWeek == dayOfWeek)
                            .length,
                        itemBuilder: (context, index) => DataChooseBox(
                          height: 50,
                          text:
                              "${loadedState.workouts.where((element) => element.dayOfWeek == dayOfWeek).toList()[index].trainingName!} - "
                              "${loadedState.workouts.where((element) => element.dayOfWeek == dayOfWeek).toList()[index].trainingTime!}"
                              " min",
                          isWorkout: true,
                          onTap: () {},
                          onTrashTap: () {
                            BlocProvider.of<WorkoutCubit>(context)
                                .deleteWorkout(
                                    workout: loadedState.workouts
                                        .where((element) =>
                                            element.dayOfWeek == dayOfWeek)
                                        .toList()[index]);
                          },
                        ),
                      ),
                    ],
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
