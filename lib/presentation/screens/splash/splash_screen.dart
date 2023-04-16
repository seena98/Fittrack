import 'package:fit_track/presentation/screens/registration/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../wokrouts/explore_workouts_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          if (state is Authenticated) {
            return const ExploreWorkoutsScreen();
          } else if (state is UnAuthenticated) {
            return LoginScreen();
          } else {
            return const Center(
              child: Text(
                "FitTrack",
                style: TextStyle(
                  color: Color(0xff0F172A),
                  fontSize: 64,
                  fontWeight: FontWeight.w700,
                  fontFamily: "inter",
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

// return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){
//
// if (authState is Authenticated){
// return HomePage(uid: authState.uid,);
// }
// if (authState is UnAuthenticated){
// return SignInPage();
// }
//
// return CircularProgressIndicator();
// });
