import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "FitTrack",
            style: TextStyle(
              color: Colors.black,
              fontSize: 64,
              fontFamily: "inter",
            ),
          ),
        ),
      ),
    );
  }
}
