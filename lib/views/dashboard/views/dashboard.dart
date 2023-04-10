import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/views/dashboard/views/uploadimageMiddleWare.dart';
import 'package:socio/widgets/Dashboard_Widgets/editOptions.dart';
import 'package:socio/widgets/Dashboard_Widgets/tabbar.dart';
import 'package:socio/widgets/Dashboard_Widgets/userInfo.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/addPost.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  CreatePost createPost = Get.put(CreatePost());
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return homeController.loading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Userinfo(),
                    SizedBox(
                      height: 20,
                    ),
                    Editoptions(),
                    SizedBox(
                      height: 20,
                    ),
                    
                    ToggleTabs(),
                  ],
                );
        }),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          createPost.IsProfilePic.value = false;
          //TODO implement pic upload
          createPost.selectImage();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          height: 60,
          width: 140,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "New Post",
                  style: GoogleFonts.caesarDressing(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                EvaIcons.image,
                  size: 25,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
