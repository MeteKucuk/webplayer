import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../components/blur.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login_bg.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment(-1, 0),
              ),
            ),
          ),
          Blur(width: Get.width, height: Get.height),
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-1, -1),
                focal: const Alignment(-.6, -.6),
                stops: const [.5, 1],
                radius: 1.2,
                colors: [
                  Colors.indigo.withOpacity(.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.transparent,
            child: SizedBox(
              width: Get.width,
              child: Lottie.asset(
                "assets/login_anim.json",
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fitWidth,
                height: Get.height * 0.08,
                repeat: true,
              ),
            ),
          ),
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: LoginForm(),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
