import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/widgets/Searchpage_widgets/searchBar.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/widgets/Searchpage_widgets/searchedList.dart';

import '../../../controllers/homecontroller.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: lightmode,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              searchBar(),
              searchedList(),
            ],
          ),
        ),
      ),
    );
  }
}