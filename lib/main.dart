import 'package:firebase_core/firebase_core.dart';
import 'package:fit_track/presentation/bloc/auth/auth_cubit.dart';
import 'package:fit_track/presentation/bloc/user/user_cubit.dart';
import 'package:fit_track/presentation/bloc/workout/workout_cubit.dart';
import 'package:fit_track/routers.dart';
import 'package:fit_track/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'injections.dart' as dependency_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initialize all the dependency injections
  await dependency_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //provided all the used cubits here
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) =>
                dependency_injection.getItHandler<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(
            create: (_) => dependency_injection.getItHandler<UserCubit>()),
        BlocProvider<WorkoutCubit>(
            create: (_) => dependency_injection.getItHandler<WorkoutCubit>()),
      ],
      child: MaterialApp(
        title: 'FitTrack',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        //provided theme factory
        theme: Themes.getInstance().light,
        // initial route to '/' splash screen
        initialRoute: '/',
        //provided routes
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
