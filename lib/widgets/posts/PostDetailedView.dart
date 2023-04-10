import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/model/postModel.dart';
import 'package:socio/model/userModel.dart';
import 'package:socio/widgets/HomeScreen_Widgets/postCard.dart';

class PostDetailedView extends StatelessWidget {
  PostDetailedView({
    super.key,
    required this.userinfo,
    required this.post
  });
 User userinfo;
 Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: lightmode,
        toolbarHeight: 50,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              EvaIcons.arrowBack,
              color: darkmode,
            )),
      ),
      body: Column(
        children: [
          PostCard(
              imageurl: post.url,
              profileUrl: userinfo.profileUrl,
              username: userinfo.name,
              caption: post.caption,
              userUid: post.ownerUid,
              index: 0,
              postuid: post.uid,
              )
        ],
      ),
    );
  }
}
