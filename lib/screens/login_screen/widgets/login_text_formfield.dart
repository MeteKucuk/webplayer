import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField(
      {Key? key,
      this.obscureText,
      this.validator,
      required this.controller,
      required this.hintText})
      : super(key: key);

  final TextEditingController? controller;
  final bool? obscureText;
  final String? hintText;
  final Validator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.white60),
        contentPadding: const EdgeInsets.only(left: 30),
      ),
      validator: validator,
    );
  }
}

typedef Validator = String? Function(String? input);
