import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/intreactionController.dart';
import 'package:socio/views/home/conditionalScreen.dart';

class PostCard extends StatelessWidget {
  PostCard({
    super.key,
    required this.imageurl,
    required this.profileUrl,
    required this.username,
    required this.caption,
    required this.userUid,
    required this.index,
    required this.postuid,
  });
  String username;
  String profileUrl;
  String imageurl;
  String caption;
  String userUid;
  dynamic index;
  String postuid;

  @override
  Widget build(BuildContext context) {
    intractionController intreactionController =
        Get.put(intractionController());
    return Container(
      height: 360,
      width: Get.width,
      child: Column(
        children: [
          Container(
            height: 40,
            width: Get.width,
            // color: Colors.pink,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileUrl),
                    radius: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(username)
                ],
              ),
            ),
          ),
          Container(
            height: 220,
            width: Get.width,
            color: SecondaryColor,
            child: CachedNetworkImage(
              imageUrl: imageurl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: darkmode,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: Get.width,
            child: Center(
                child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    print(intreactionController.likes.toList().toString());

                    homeController.allFeeds[index].likes
                            .contains(homeController.user.value.uid)
                        ? intreactionController.postLikeRemove(
                            postuid, homeController.user.value.uid)
                        : intreactionController.postLikeAdd(
                            postuid, homeController.user.value.uid);
                  },
                  icon: homeController.allFeeds[index].likes
                          .contains(homeController.user.value.uid)
                      ? Icon(
                          EvaIcons.heart,
                          color: Colors.red,
                        )
                      : Icon(EvaIcons.heartOutline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(EvaIcons.messageCircleOutline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(EvaIcons.paperPlane),
                ),
              ],
            )),
          ),
          Container(
              height: 65,
              width: Get.width,
              // color: Colors.pink,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Liked by $username and 29 Others..."),
                    Row(
                      children: [
                        Text(username,
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 5),
                        Text(caption),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
