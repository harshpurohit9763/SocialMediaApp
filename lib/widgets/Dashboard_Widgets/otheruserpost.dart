import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/model/postModel.dart';
import 'package:socio/widgets/posts/PostDetailedView.dart';

class otherUserPost extends StatelessWidget {
  otherUserPost({super.key, required this.data});
  Map<String,dynamic> data;
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.loading.value
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Container(
              height: Get.height * 0.4,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: homeController.otherUserPostList.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = homeController.otherUserPostList[index];

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: Get.height * 0.2,
                      width: 100,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            PostDetailedView( userinfo: homeController.otheruser.value,post: post,),
                            arguments: post.url,
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: post.url,
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
                  );
                },
              ),
            );
    });
  }
}
