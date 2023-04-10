import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socio/controllers/addPost.dart';
import 'package:socio/controllers/homecontroller.dart';

import '../controllers/loginController.dart';

final fire_name = FirebaseAuth.instance.currentUser?.displayName as String;
final fire_email = FirebaseAuth.instance.currentUser?.email as String;
final auth = FirebaseAuth.instance;
final firebase = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
final storageRef = storage.ref();
CreatePost createPost = Get.find<CreatePost>();

LoginController loginController = Get.put(LoginController());
var profileImage = storage.ref().child("profile-images/");
var postimages = storage.ref().child("/Post-images");
final userStream =
    firebase.collection("Users").doc(auth.currentUser?.uid).snapshots();
