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
  await dependency_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        theme: Themes.getInstance().light,
        // initial route to '/' splash screen
        initialRoute: '/',
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
