import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/controllers/loginController.dart';

class Editoptions extends StatelessWidget {
   Editoptions({super.key});
LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text("Edit Profile"),
            ),
          ),
          GestureDetector(
            onTap: () {
              loginController.signout();
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red[300], borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text("Logout"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
