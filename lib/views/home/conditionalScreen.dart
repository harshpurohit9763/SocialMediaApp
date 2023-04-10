import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/views/home/homeScreen.dart';

import '../authentication/views/signup.dart';

class ConditionalScreen extends StatefulWidget {
  const ConditionalScreen({super.key});

  @override
  State<ConditionalScreen> createState() => _ConditionalScreenState();
}
HomeController homeController = Get.put(HomeController());
class _ConditionalScreenState extends State<ConditionalScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ? switchScreen() : Signup();
      },
    );
  }
}

