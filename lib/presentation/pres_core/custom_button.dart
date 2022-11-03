
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function callback;
  const CustomButton({ required this.buttonText, required this.callback, super.key});

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);
    return GestureDetector(  //InkResponse
      onTap: () => callback(),
      child: Container(
        height: 60,
        width:  double.infinity,
        decoration: BoxDecoration(
          color: themeData.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12)),
        child: Center(child: Text(
          buttonText,
          style: themeData.textTheme.headline2!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
            ),)),
      ),
    );
  }
}