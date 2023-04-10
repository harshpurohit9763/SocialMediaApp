import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/controllers/homecontroller.dart';

class intractionController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  // to add the data of the likes
  RxList likes = [].obs;
  RxBool isliked = false.obs;
  var convoId = '';
  TextEditingController textMsg = TextEditingController();
  var type = '';

  //TODO PENDING
  postLikeAdd(String postuid, String userUid) async {
    likes.value.add(userUid);
    await firebase.collection('posts').doc(postuid).update({
      'Likes': likes,
    });
  }

  postLikeRemove(String postuid, String userUid) async {
    likes.value.remove(userUid);
    await firebase.collection('posts').doc(postuid).update({
      'Likes': likes,
    });
  }

  getConversationId(String id) {
    convoId = homeController.user.value.uid.hashCode <= id.hashCode
        ? "${homeController.user.value.uid}_$id"
        : "${id}_${homeController.user.value.uid}";
    return convoId;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getallMessages(String uid) {
    return firebase
        .collection('chats')
        .doc(getConversationId(uid))
        .collection('messages')
        .snapshots();
  }

  sendMessage(String sender, String reciver) async {
    await firebase.collection('Chats').doc(convoId).collection('Messages').add({
      'Message': textMsg.text,
      'Sender': sender,
      'Reciver': reciver,
      'Time': DateTime.now(),
      'Type': type,
    });
    textMsg.clear();
  }

  addChatroom(String sender, String reciver) async {
    List<String> oldArr = homeController.user.value.chatroom;
    oldArr.add(convoId);
    await firebase.collection('Users').doc(auth.currentUser?.uid).update({
      'chatroom': oldArr,
    });
    await firebase
        .collection('Users')
        .doc(homeController.otheruser.value.uid)
        .update({
      'chatroom': oldArr,
    }).whenComplete(
      () => sendMessage(sender, reciver),
    );
  }
}
