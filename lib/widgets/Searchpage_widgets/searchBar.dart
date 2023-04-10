import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socio/controllers/homecontroller.dart';

class searchBar extends StatelessWidget {
  searchBar({super.key});
HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Container(
         
          height: 50,
          width: Get.width * 0.8,
          child: Center(
            child: TextFormField(
              controller: homeController.searchController,
              onChanged: (value) {
                homeController.userNameSearch.value = value;
              },
              cursorHeight: 30,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
