import 'package:flutter/material.dart';

class LoginElevatatedButton extends StatelessWidget {
  const LoginElevatatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.padding,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          letterSpacing: 1.2,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: 5,
        primary: Colors.deepOrange.withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
