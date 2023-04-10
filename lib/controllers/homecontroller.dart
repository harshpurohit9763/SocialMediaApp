import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:socio/model/postModel.dart';
import 'package:socio/model/userModel.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt selectedTabIndex = 0.obs;
  Rx<User> user = User.initialize().obs;
  Rx<User> otheruser = User.initialize().obs;
  RxList userPostList = [].obs;
  RxList otherUserPostList = [].obs;
  var loading = false.obs;
  RxString userNameSearch = ''.obs;
  TextEditingController searchController = TextEditingController();
  RxList following = [].obs;
  RxList follower = [].obs;
  //List of all the documents of users Current user follow
  List<User> allUserDocumentSnapshot = [];
  //To Store all the docid of all user post that Current user follow
  List<Post> allFeeds = [];

  Future<void> OtherUserData(String uid) async {
    loading.value = true;
    DocumentSnapshot userSnap =
        await firebase.collection("Users").doc(uid).get();
    otheruser.value = User.fromJson(userSnap.data() as Map<String, dynamic>);
    loading.value = false;
    following.value = otheruser.value.following;
    follower.value = otheruser.value.followers;
    otherUserPostList.value = [];

    for (uid in otheruser.value.posts) {
      DocumentSnapshot postSnap =
          await firebase.collection('posts').doc(uid).get();
      otherUserPostList
          .add(Post.fromJson(postSnap.data() as Map<String, dynamic>));
    }
    loading.value = false;
  }

  Future<void> loadUser() async {
    loading.value = true;
    DocumentSnapshot userSnap =
        await firebase.collection("Users").doc(auth.currentUser!.uid).get();
    user.value = User.fromJson(userSnap.data() as Map<String, dynamic>);
    following.value = user.value.following;
    follower.value = user.value.followers;
    userPostList.value = [];

    for (var docUid in user.value.posts) {
      DocumentSnapshot postSnap =
          await firebase.collection('posts').doc(docUid).get();
      userPostList.add(Post.fromJson(postSnap.data() as Map<String, dynamic>));
    }
    loadAllPost();
    loading.value = false;
  }

  searchUser() {
    loading.value = true;
    firebase.collection('Users').doc().snapshots();
    loading.value = false;
  }

  addFriend(String otherUID) async {
    following.value.add(otherUID);
    await firebase
        .collection('Users')
        .doc(auth.currentUser?.uid)
        .update({"following": following});
    following.value.clear();
    DocumentSnapshot otherUserSnap =
        await firebase.collection('Users').doc(otherUID).get();
    User otherUser =
        User.fromJson(otherUserSnap.data() as Map<String, dynamic>);
    List<String> otherUserFollowers = otherUser.followers;
    otherUserFollowers.add(auth.currentUser!.uid);
    await firebase.collection('Users').doc(otherUID).update(
      {
        "followers": otherUserFollowers,
      },
    );
  }

  removeFriend(String otherUID) async {
    following.value.remove(otherUID);
    await firebase
        .collection('Users')
        .doc(auth.currentUser?.uid)
        .update({"following": following});

    DocumentSnapshot otherUserSnap =
        await firebase.collection('Users').doc(otherUID).get();
    User otherUser =
        User.fromJson(otherUserSnap.data() as Map<String, dynamic>);
    List<String> otherUserFollowers = otherUser.followers;
    otherUserFollowers.remove(auth.currentUser?.uid);
    await firebase.collection('Users').doc(otherUID).update({
      "followers": otherUserFollowers,
    });
  }

  loadAllPost() async {
    loading.value = true;
    allUserDocumentSnapshot = [];
    List<String> uidsofFollowing = user.value.following;
    for (var uid in user.value.following) {
      DocumentSnapshot docsnap =
          await firebase.collection("Users").doc(uid).get();
      allUserDocumentSnapshot
          .add(User.fromJson(docsnap.data() as Map<String, dynamic>));
    }
    following.value = user.value.following;
    follower.value = user.value.followers;
    allFeeds = [];
    print(allUserDocumentSnapshot);
    for (User user in allUserDocumentSnapshot) {
      for (var docid in user.posts) {
        DocumentSnapshot allposts =
            await firebase.collection('posts').doc(docid).get();
        allFeeds.add(Post.fromJson(allposts.data() as Map<String, dynamic>));
      }
    }
    print("Hello world");
    print(allFeeds.toList().toString());
    loading.value = false;
  }
}
