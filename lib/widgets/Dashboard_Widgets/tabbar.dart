import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socio/widgets/Dashboard_Widgets/Posts.dart';
import 'package:socio/widgets/Dashboard_Widgets/TagPosts.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';

class ToggleTabs extends StatelessWidget {
  ToggleTabs({super.key});

  List page = [
    MinePosts(),
    TaggedPosts(),
  ];
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.58,
      child: DefaultTabController(
          length: 2,
          child: Obx(() => Column(
                children: [
                  TabBar(
                    onTap: (value) {
                      homeController.selectedTabIndex.value = value;
                    },
                    tabs: [
                      Tab(
                          icon: LineIcon(
                        LineIcons.image,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: LineIcon(
                        LineIcons.userTag,
                        color: Colors.black,
                      )),
                    ],
                  ),
                  page[homeController.selectedTabIndex.value],
                ],
              ))),
    );
  }
}
