import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/constants/colorConstants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });
  double height;
  double width;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: inputboxColor,
        border: Border.all(color: SecondaryColor)
            ),
            child: Center(child: Text(text,style: GoogleFonts.openSans(fontSize: 22,fontWeight: FontWeight.bold),)),
    );
  }
}
