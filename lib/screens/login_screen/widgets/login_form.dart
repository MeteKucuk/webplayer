import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/screens/login_screen/widgets/login_elevatated_button.dart';
import 'package:music_player/screens/login_screen/widgets/login_text_formfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                left: widthSize * 0.05,
                right: widthSize * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Giriş Yap',
                    style: GoogleFonts.actor(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginTextFormField(
                    controller: mailController,
                    hintText: 'E-posta',
                    obscureText: false,
                    validator: _emailValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginTextFormField(
                    controller: passwordController,
                    hintText: 'Şifre ',
                    obscureText: true,
                    validator: _passwordValidator,
                  ),
                  const SizedBox(height: 50),
                  LoginElevatatedButton(
                    title: 'Giriş',
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 75),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = mailController.text.trim();
                        String password = passwordController.text;
                      }
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }

  ///Password should contain at least 1 uppercase letter, 1 lowercase letter,
  ///1 digit and minimum length should be 6.
  String? _passwordValidator(String? pass) {
    bool _isEmailValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(pass!);
    if (!_isEmailValid) {
      return 'Hatalı şifre';
    }
    return null;
  }

  String? _emailValidator(String? mail) {
    bool _isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail!);
    if (!_isEmailValid) {
      return 'Geçersiz E-posta';
    }
    return null;
  }
}
