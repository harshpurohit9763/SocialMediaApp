import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/widgets/Dashboard_Widgets/otheruserProfileDashboard.dart';

class searchedList extends StatelessWidget {
  searchedList({super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: StreamBuilder<QuerySnapshot>(
        stream: firebase.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    var data = snapshot.data?.docs[index].data()
                        as Map<String, dynamic>;

                    return Obx(() {
                      if (homeController.userNameSearch.value.isEmpty &&
                          data['uid'] != auth.currentUser!.uid) {
                        return GestureDetector(
                          onTap: () {
                            // var fetchedData =  homeController.OtherUserData(data['uid']);
                            //TODO fo to user page
                            print("This is the other user uid");
                            print(data['uid']);
                            Get.to(
                              OtherUserProfile(data: data),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              data['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(data['profile_pic']),
                            ),
                            subtitle: Text(data['bio']),
                            trailing: GestureDetector(
                              onTap: () {
                                data['followers']
                                        .contains(auth.currentUser!.uid)
                                    ? homeController.removeFriend(data['uid'])
                                    : homeController.addFriend(data['uid']);
                              },
                              child: data['followers']
                                      .contains(auth.currentUser!.uid)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: unfollowColour,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Unfollow",
                                          style: GoogleFonts.openSans(
                                              color: lightmode),
                                        ),
                                      ))
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: followColour,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Follow",
                                          style: GoogleFonts.openSans(
                                              color: lightmode),
                                        ),
                                      )),
                            ),
                          ),
                        );
                      } else if (data['name']
                              .toString()
                              .toLowerCase()
                              .startsWith(homeController.userNameSearch.value
                                  .toLowerCase()) &&
                          data['uid'] != auth.currentUser!.uid) {
                        return GestureDetector(
                          onTap: () async {
                            print("This is the other user uid");
                            print(data['uid']);
                            // homeController.OtherUserData(data['uid']);
                            Get.to(
                              OtherUserProfile(
                                data: data,
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              data['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(data['profile_pic']),
                            ),
                            subtitle: Text(data['bio']),
                            trailing: GestureDetector(
                              onTap: () {
                                data['followers']
                                        .contains(auth.currentUser!.uid)
                                    ? homeController.removeFriend(data['uid'])
                                    : homeController.addFriend(data['uid']);
                              },
                              child: data['followers']
                                      .contains(auth.currentUser!.uid)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: unfollowColour,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Unfollow",
                                          style: GoogleFonts.openSans(
                                              color: lightmode),
                                        ),
                                      ))
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: followColour,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Follow",
                                          style: GoogleFonts.openSans(
                                              color: lightmode),
                                        ),
                                      )),
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
                  },
                );
        },
      ),
    );
  }
}
