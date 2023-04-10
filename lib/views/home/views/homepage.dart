import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/model/userModel.dart';
import 'package:socio/widgets/HomeScreen_Widgets/homeheader.dart';
import 'package:socio/widgets/HomeScreen_Widgets/postCard.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              AppBarHome(),
              Container(
                child: homeController.allFeeds.length == 0
                    ? Center(
                        child: SizedBox(
                          child: Text("Nothing to view"),
                        ),
                      )
                    : SizedBox(
                        // color: Colors.amber,
                        height: Get.height,
                        child: ListView.builder(
                          itemCount: homeController.allFeeds.length,
                          itemBuilder: (BuildContext context, int index) {
                            return homeController.allFeeds.isEmpty &&
                                    homeController.loading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: darkmode,
                                  ))
                                : PostCard(
                                    imageurl:
                                        homeController.allFeeds[index].url,
                                    profileUrl: homeController
                                        .allFeeds[index].profileUrl,
                                    username:
                                        homeController.allFeeds[index].username,
                                    caption:
                                        homeController.allFeeds[index].caption,
                                    userUid: homeController.allFeeds[index].ownerUid,
                                    index: index,
                                    postuid: homeController.allFeeds[index].uid,
                                  );
                          },
                        ),
                      ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
