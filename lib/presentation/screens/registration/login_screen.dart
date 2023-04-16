import 'package:fit_track/presentation/screens/global_widgets/custom_button.dart';
import 'package:fit_track/presentation/screens/registration/registration_screen.dart';
import 'package:fit_track/presentation/screens/wokrouts/explore_workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/user/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.longestSide;
    // var width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
            child: BlocConsumer<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return const ExploreWorkoutsScreen();
                } else {
                  return body(height: height);
                }
              });
            }

            return body(height: height);
          },
          listener: (context, userState) {
            if (userState is UserSuccess) {
              debugPrint("login success");
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (userState is UserFailure) {
              debugPrint("failed");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('invalid email or password'),
                ),
              );
            }
          },
        )),
      ),
    );
  }

  void submitSignIn() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
          user: UserEntity(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  body({
    required double height,
  }) {
    return Padding(
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
          TextField(
            controller: emailController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
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
            onTap: () {
              submitSignIn();
            },
            child: const CustomButton(
              buttonHeight: 44,
              buttonWidth: double.infinity,
              text: "Sign in",
            ),
          ),
        ],
      ),
    );
  }
}
