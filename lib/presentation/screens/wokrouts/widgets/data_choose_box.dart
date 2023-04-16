import 'package:flutter/material.dart';

class DataChooseBox extends StatelessWidget {
  final double height;
  final String text;
  final bool? isWorkout;
  final Function()? onTrashTap;
  final Function()? onTap;

  const DataChooseBox({
    required this.height,
    required this.text,
    this.isWorkout = false,
    this.onTrashTap,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      padding:
          isWorkout == true ? const EdgeInsets.symmetric(horizontal: 10) : null,
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: isWorkout == true
          ? Row(
              children: [
                InkWell(
                  onTap: onTap,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: onTrashTap, child: const Icon(Icons.delete_outlined))
              ],
            )
          : Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}
