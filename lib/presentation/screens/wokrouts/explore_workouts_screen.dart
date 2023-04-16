import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                        onTap: () {},
                        child: const Text(
                          "<  Days",
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
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
