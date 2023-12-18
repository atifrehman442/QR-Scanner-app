import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final double height;
  final double width;
  final Color borderColor;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.color,
    required this.textColor,
    required this.height,
    required this.width,
    required this.borderColor,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: textColor),
          ),
        ),
      ),
    );
  }
}
