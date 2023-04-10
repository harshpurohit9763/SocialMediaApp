import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/controllers/intreactionController.dart';
import 'package:socio/model/userModel.dart';
import 'package:socio/views/chats/chatScreen.dart';
import 'package:socio/views/home/conditionalScreen.dart';
import 'package:socio/widgets/Dashboard_Widgets/Posts.dart';
import 'package:socio/widgets/Dashboard_Widgets/TagPosts.dart';
import 'package:socio/widgets/Dashboard_Widgets/otheruserpost.dart';

class OtherUserProfile extends StatefulWidget {
  OtherUserProfile({
    super.key,
    required this.data,
  });

  Map<String, dynamic> data;
  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.OtherUserData(widget.data['uid']);
  }

  @override
  Widget build(BuildContext context) {
     List page = [
    otherUserPost(data: widget.data,),
    TaggedPosts(),
  ];
    HomeController homeController = Get.find<HomeController>();
    intractionController intreactionController = Get.put(intractionController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        backgroundColor: lightmode,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              EvaIcons.arrowBack,
              color: darkmode,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        imageUrl: homeController.otheruser.value.profileUrl,
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
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeController.otheruser.value.name,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          homeController.otheruser.value.bio,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController.otheruser.value.followers
                                .contains(auth.currentUser!.uid)
                            ? homeController.removeFriend(
                                homeController.otheruser.value.uid)
                            : homeController.addFriend(
                                homeController.otheruser.value.uid);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child:  homeController.otheruser.value.followers
                                  .contains(auth.currentUser!.uid)
                              ? Text(
                                  "Unfollow",
                                  style: GoogleFonts.openSans(color: lightmode),
                                )
                              : Text(
                                  "Follow",
                                  style: GoogleFonts.openSans(color: lightmode),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            intreactionController.getConversationId(homeController.otheruser.value.uid);
                            Get.to(()=> ChatScreen());
                          },
                          child: Center(
                            child: Text("Message"),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 50,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
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
                      ],
                    ),
                  ),
                ),
                page[homeController.selectedTabIndex.value],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
