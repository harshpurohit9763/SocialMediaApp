import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/textfield.dart';
import 'package:socio/controllers/addPost.dart';
import 'package:socio/views/home/homeScreen.dart';

class UploadImageMiddleware extends StatelessWidget {
  UploadImageMiddleware({super.key});
  CreatePost createPostController = Get.find<CreatePost>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => createPostController.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: courserColorPrimary,
                ),
              )
            : Scaffold(
                backgroundColor: primaryColor,
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Image.file(
                            File(createPostController.imgFile.value.path),fit: BoxFit.fitWidth,filterQuality: FilterQuality.high,),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  createPostController.IsProfilePic.value
                                      ? createPostController.updateProfilePic()
                                      : createPostController.addPost();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(EvaIcons.arrowRight),
                                )),
                          )),
                      Positioned(
                        left: 10,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: 
                           createPostController.IsProfilePic.value
                                      ? Container():
                          
                           Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width: Get.width * 0.7,
                              child: TextField(
                                controller: createPostController.caption,
                                cursorHeight: 30,
                                decoration: InputDecoration(
                                    fillColor: lightmode,
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: "Add Caption..."),
                              )),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.off(() => switchScreen());
                              },
                              child: Icon(EvaIcons.close))),
                    ],
                  ),
                )),
      ),
    );
  }
}
