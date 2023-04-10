import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socio/model/userModel.dart';
import 'package:socio/views/dashboard/views/uploadimageMiddleWare.dart';
import 'package:socio/views/home/homeScreen.dart';
import 'package:socio/constants/constantvalues.dart';
import 'package:path/path.dart';
import 'package:socio/controllers/homecontroller.dart';

class CreatePost extends GetxController {
  Rx<File> imgFile = File("").obs;
  RxString uploadedUrl = "".obs;
  String docid = "";
  var loading = false.obs;
  RxBool IsProfilePic = false.obs;
  TextEditingController caption = TextEditingController();
  HomeController homeController = Get.find<HomeController>();
  Rx<User> user = User.initialize().obs;
  selectImage() async {
    final picker = ImagePicker();
    final imagefile = await picker.pickImage(source: ImageSource.gallery);
    imgFile.value = File(imagefile!.path);
    Get.to(UploadImageMiddleware());
  }

  addPost() async {
    try {
      //uploading image to firebase storage
      loading.value = true;
      String fileName = basename(imgFile.value.path);
      String uid = auth.currentUser!.uid;
      String uploadFileName = fileName + uid;
      final imageRef = postimages.child(uploadFileName);
      await imageRef.putFile(imgFile.value);
      uploadedUrl.value = await imageRef.getDownloadURL();

      //creating post doc on firestore
      await firebase.collection('posts').add({
        "url": uploadedUrl.value,
        "created-on": DateTime.now(),
        "username": auth.currentUser?.displayName.toString(),
        "caption": caption.text,
        "owner-uid": auth.currentUser?.uid,
        "uid": "",
        'userProfile': homeController.user.value.profileUrl,
        'Likes':[],
        'comments':[],
      }).then((value) async {
        //updating uid of the created post's document
        await firebase
            .collection("posts")
            .doc(value.id)
            .update({'uid': value.id});
        docid = value.id;
        //saving this post's uid in user's posts list
        //get posts array of the user from local user variable
        //then add the {value.id} i.e the id of the new uploaded post to the old list
        //now upload this new list of posts
        //
        List<String> oldArr = homeController.user.value.posts;
        oldArr.add(docid);
        await firebase
            .collection("Users")
            .doc(auth.currentUser!.uid)
            .update({'posts': oldArr});
        await homeController.loadUser();
      });
    } on FirebaseException catch (e) {
      print("Firebase error: $e");
    } catch (e) {
      print("Some error: $e");
    }
    print(url);
    loading.value = false;

    Get.off(switchScreen());
  }

  updateProfilePic() async {
    try {
      //uploading image to firebase storage
      loading.value = true;
      String fileName = basename(imgFile.value.path);
      String uid = auth.currentUser!.uid;
      String uploadFileName = fileName + uid;
      final imageRef = profileImage.child(uploadFileName);
      await imageRef.putFile(imgFile.value);
      uploadedUrl.value = await imageRef.getDownloadURL();

      //creating post doc on firestore
      await firebase
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .update({"profile_pic": uploadedUrl.value});
    } on FirebaseException catch (e) {
      print("Firebase error: $e");
    } catch (e) {
      print("Some error: $e");
    }
    print(url);
    loading.value = false;
    Get.off(switchScreen());
  }
}
