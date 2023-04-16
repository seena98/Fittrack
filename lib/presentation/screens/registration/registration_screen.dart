import 'package:fit_track/presentation/screens/global_widgets/custom_button.dart';
import 'package:fit_track/presentation/screens/registration/login_screen.dart';
import 'package:fit_track/presentation/screens/wokrouts/explore_workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/user/user_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/registration-screen";

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: SafeArea(
          child: BlocConsumer<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserSuccess) {
                return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                  if (authState is Authenticated) {
                    return const ExploreWorkoutsScreen();
                  } else {
                    return body(theme: theme, height: height);
                  }
                });
              }

              return body(theme: theme, height: height);
            },
            listener: (context, userState) {
              if (userState is UserSuccess) {
                BlocProvider.of<AuthCubit>(context).loggedIn();
              }
              if (userState is UserFailure) {
                const SnackBar(content: Text('invalid email'));
              }
            },
          ),
        ));
  }

  body({
    required ThemeData theme,
    required double height,
  }) {
    return SingleChildScrollView(
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
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: const Text(
                      "<  Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: TextField(
              controller: usernameController,
              cursorColor: Colors.black,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Your Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: TextField(
              controller: emailController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(hintText: "Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: TextField(
              controller: passwordController,
              cursorColor: Colors.black,
              obscureText: true,
              decoration:
                  const InputDecoration(hintText: "Password +8 characters"),
            ),
          ),
          SizedBox(
            height: height / 22,
          ),
          InkWell(
            onTap: () {
              submitSignUp();
            },
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: CustomButton(
                  buttonHeight: 44,
                  buttonWidth: double.infinity,
                  text: "Create Account"),
            ),
          ),
        ],
      ),
    );
  }

  void submitSignUp() {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
          user: UserEntity(
        email: emailController.text,
        password: passwordController.text,
        name: usernameController.text,
      ));
    }
  }
}
