import 'package:flutter/material.dart';

///this is the dark button used all over the app
class CustomButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final String text;

  const CustomButton({
    required this.buttonHeight,
    required this.buttonWidth,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
