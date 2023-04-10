import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LineIcon(
            LineIcons.bell,
            color: Colors.black,
          ),
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
            repeatForever: true,
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 6000),
          ),
          GestureDetector(
              onTap: () {
                loginController.signout();
              },
              child:  LineIcon(
                  LineIcons.codepen,
                  color: Colors.black,
                ),),
        ],
      ),
    );
  }
}
