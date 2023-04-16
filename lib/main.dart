import 'package:fit_track/routers.dart';
import 'package:fit_track/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.getInstance().light,
      // initial route to '/' splash screen
      initialRoute: '/',
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
