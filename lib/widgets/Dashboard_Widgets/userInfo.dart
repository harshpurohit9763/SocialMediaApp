import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';

class Userinfo extends StatelessWidget {
  Userinfo({super.key});
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "",
                    titleStyle: TextStyle(fontSize: 0),
                    titlePadding: EdgeInsets.zero,
                    middleText: "",
                    middleTextStyle: TextStyle(fontSize: 0),
                    contentPadding: EdgeInsets.zero,
                    actions: [
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                createPost.IsProfilePic.value = true;
                                createPost.selectImage();
                              },
                              child: Text("Change Profile")),
                          Divider(
                            thickness: 1,
                            color: primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                      title: "",
                                      backgroundColor: Colors.transparent,
                                      middleText: "",
                                      titleStyle: TextStyle(fontSize: 0),
                                      middleTextStyle: TextStyle(fontSize: 0),
                                      content: Container(
                                        height: Get.height * 0.3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: CachedNetworkImage(
                                            imageUrl: homeController
                                                .user.value.profileUrl,
                                            fit: BoxFit.fitWidth,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: darkmode,
                                                ))),
                                      ));
                                },
                                child: Text("See Profile image")),
                          ),
                        ],
                      )
                    ],
                  );
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: homeController.user.value.profileUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: darkmode,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fire_name,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    homeController.user.value.bio,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
