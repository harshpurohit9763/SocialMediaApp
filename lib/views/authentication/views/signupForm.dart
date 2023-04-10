import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/views/home/conditionalScreen.dart';
import 'package:socio/views/home/homeScreen.dart';
import 'package:socio/controllers/loginController.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/constants/custombutton.dart';
import 'package:socio/constants/textfield.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/bg.png',
            ),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "welcome Abord...",
                        textStyle: GoogleFonts.openSans(
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
                  CustomTextField(
                      controller: loginController.name,
                      icon: const Icon(EvaIcons.person),
                      text: "name"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: loginController.email,
                      icon: const Icon(EvaIcons.email),
                      text: "email"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: loginController.bio,
                      icon: const Icon(EvaIcons.text),
                      text: "Bio"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: loginController.dob,
                      icon: const Icon(EvaIcons.calendar),
                      text: "Birthday(DD/MM/YYYY)"),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      loginController.signup();
                    },
                    child: CustomButton(
                      width: Get.width - 100,
                      height: 50,
                      text: "Let's Go",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
