import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/controllers/loginController.dart';
import 'package:socio/views/authentication/views/signupForm.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/custombutton.dart';
import 'package:socio/constants/textfield.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/bg.png',
          ),
          fit: BoxFit.cover,
        )
        
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Socio",
                  textStyle: GoogleFonts.caesarDressing(
                      fontSize: 42,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                  speed: const Duration(milliseconds: 500),
                ),
              ],
              totalRepeatCount: 1,
              isRepeatingAnimation: true,
              pause: const Duration(milliseconds: 6000),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Be A Socio Star",
                  textStyle: GoogleFonts.caesarDressing(
                      fontSize: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 6000),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: loginController.email,
                    icon: const Icon(EvaIcons.email),
                    text: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: loginController.password,
                    icon: const Icon(EvaIcons.lock),
                    text: "Password",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      loginController.signin();
                    },
                    child: CustomButton(
                      width: Get.width -100,
                      height: 50,
                      text: "Let's Go",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
