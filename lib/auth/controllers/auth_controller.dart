import 'package:afolio06/auth/models/users_model.dart';
import 'package:afolio06/auth/views/loginpage.dart';
import 'package:afolio06/controllers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController myEmail = TextEditingController();
  final TextEditingController myPassword = TextEditingController();
  final TextEditingController myName = TextEditingController();

  bool validateForm() {
    if (!GetUtils.isEmail(myEmail.text)) {
      Get.snackbar('Error', 'Invalid Email');
      return false;
    } else if (myPassword.text.length < 8) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addUser(UsersModel user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('USERS');

    return await FirebaseFirestore.instance
        .collection('USERS')
        .doc(user.id)
        .set(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> registerUser() async {
    var errormsg = 'User created Successfully';
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .createUserWithEmailAndPassword(
              email: myEmail.text, password: myPassword.text)
          .then((result) async {
        String _userId = result.user!.uid;
        final UsersModel user = UsersModel.fromJson({
          'id': _userId,
          'email': myEmail.text,
          'name': myName.text,
        });
        await addUser(user);
        Get.find<GlobalController>().currentUser.value = user;
      });
      Get.defaultDialog(title: 'Message', middleText: errormsg, actions: [
        ElevatedButton(
          child: Text("Ok"),
          onPressed: () {
            Get.to(LoginPage());
          },
        )
      ]);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        errormsg = 'The password provided is too weak.';
      } else if (error.code == 'email-already-in-use') {
        errormsg = 'The account already exists for that email.';
      } else {
        errormsg = error.message.toString();
      }
      Get.defaultDialog(title: 'Error Message', middleText: errormsg);
    } catch (e) {
      errormsg = "Dont know";
      Get.defaultDialog(title: 'Error Message', middleText: errormsg);
    }
  }
}
