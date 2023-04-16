import 'package:fit_track/presentation/screens/global_widgets/custom_button.dart';
import 'package:fit_track/presentation/screens/registration/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.longestSide;
    var width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 10,
              ),
              const Text(
                "Hi, Welcome Back",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Login in to your account",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffB5B5B5),
                ),
              ),
              SizedBox(
                height: height / 14,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RegistrationScreen.routName);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 6,
              ),
              InkWell(
                onTap: () {},
                child: const CustomButton(
                  buttonHeight: 44,
                  buttonWidth: double.infinity,
                  text: "Sign in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
