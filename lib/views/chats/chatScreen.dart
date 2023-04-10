import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socio/constants/colorConstants.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';
import 'package:socio/controllers/intreactionController.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  intractionController intractioncontroller = Get.find<intractionController>();
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    EvaIcons.arrowBack,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(homeController.otheruser.value.profileUrl),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        homeController.otheruser.value.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  EvaIcons.menu2,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              // color: Colors.amber,
              height: Get.height * 0.87,
              child: StreamBuilder(
                  stream: firebase
                      .collection('Chats')
                      .doc(intractioncontroller.convoId)
                      .collection('Messages')
                      .orderBy('Time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding:  EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (snapshot.data.docs[index]
                                              ['Sender'] ==
                                          auth.currentUser?.uid
                                      ? Alignment.topRight
                                      : Alignment.topLeft),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (snapshot.data.docs[index]
                                                  ['Sender'] ==
                                              auth.currentUser?.uid
                                          ? reciverChatBubblecolour
                                          : senderChatBubblecolour),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      snapshot.data.docs[index]['Message'],
                                      style: GoogleFonts.openSans(fontSize: 15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
                  }))),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          width: Get.width,
          decoration: BoxDecoration(
              color: lightmode,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.lightBlue)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    child: Icon(EvaIcons.smilingFaceOutline)),
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 25,
                  child: Container(
                    height: 60,
                    width: Get.width * 0.7,
                    child: TextField(
                      controller: intractioncontroller.textMsg,
                      decoration: InputDecoration(
                          helperMaxLines: 3,
                          border: InputBorder.none,
                          hintText: "Message...",
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: GoogleFonts.openSans(fontSize: 22)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 45,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: inputboxColor,
                                          radius: 40,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: inputboxColor,
                                          radius: 40,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: inputboxColor,
                                          radius: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              senderChatBubblecolour,
                                          radius: 40,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              senderChatBubblecolour,
                                          radius: 40,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              senderChatBubblecolour,
                                          radius: 40,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Icon(
                      EvaIcons.attach2Outline,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      if (homeController.user.value.chatroom
                          .contains(intractioncontroller.convoId)) {
                        intractioncontroller.sendMessage(
                            homeController.user.value.uid,
                            homeController.otheruser.value.uid);
                      }
                      if (homeController.user.value.chatroom.isEmpty) {
                        intractioncontroller.addChatroom(
                            homeController.user.value.uid,
                            homeController.otheruser.value.uid);
                      }
                    },
                    child: Icon(
                      EvaIcons.paperPlaneOutline,
                      color: reciverChatBubblecolour,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
