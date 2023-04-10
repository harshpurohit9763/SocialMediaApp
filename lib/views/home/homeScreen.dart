import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socio/views/dashboard/views/dashboard.dart';
import 'package:socio/views/home/views/homepage.dart';
import 'package:socio/views/search/views/search.dart';
import 'package:socio/controllers/loginController.dart';
import 'package:socio/controllers/homecontroller.dart';

import '../../constants/colorConstants.dart';

class switchScreen extends StatefulWidget {
  switchScreen({super.key});

  @override
  State<switchScreen> createState() => _switchScreenState();
}

class _switchScreenState extends State<switchScreen> {
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());

  static List<Widget> pages = [
    Homepage(),
    SearchPage(),
    Dashboard(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      homeController.loadUser();
      homeController.searchUser();
      // homeController.loadAllPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => loginController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pages[homeController.selectedIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            homeController.selectedIndex.value = value;
          },
          currentIndex: homeController.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
                icon: LineIcon(
                  LineIcons.home,
                  color: Colors.black,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: LineIcon(
                  LineIcons.search,
                  color: Colors.black,
                ),
                label: "Find"),
            BottomNavigationBarItem(
                icon: LineIcon(
                  LineIcons.userCircle,
                  color: Colors.black,
                ),
                label: "Account")
          ]),
    );
  }
}
