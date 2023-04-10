import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socio/views/home/homeScreen.dart';
import 'package:socio/views/authentication/views/signupForm.dart';
import 'package:socio/constants/constantvalues.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isLoading = false.obs;

  signin() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .whenComplete(() => switchScreen());
    } catch (signinerror) {
      if (signinerror is FirebaseAuthException) {
        if (signinerror.code == 'user-not-found') {
          Get.to(() => SignupForm());
        }
      }
    }
    isLoading.value =false;
  }

  signup() async {
      isLoading.value = true;

    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name.text);
      await FirebaseAuth.instance.currentUser?.updateEmail(email.text);
      await firebase.collection('Users').doc(credential.user?.uid).set({
        "name": name.text,
        "email": email.text,
        "bio": bio.text,
        "dob": dob.text,
        "uid": FirebaseAuth.instance.currentUser?.uid.toString(),
        "profile_pic": "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651__340.png",
        "following": [],
        "followers":[],
        "posts":[],
        "chatroom":[],
      }).whenComplete(() => Get.offAll(switchScreen()));
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /// `foo@bar.com` has alread been registered.
          signin();
        }
      }
    }
    isLoading.value =false;

  }

  signout() {
    FirebaseAuth.instance.signOut();
  }
}
