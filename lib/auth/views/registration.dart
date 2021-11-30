import 'package:afolio06/auth/controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'loginpage.dart';

class RegistrationView extends GetView<AuthController> {
  final authContoller = Get.put(AuthController());

  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: Colors.lightBlue,
          padding: constraints.maxWidth < 500
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Welcome to the app, please register"),
                    TextField(
                        controller: controller.myName,
                        decoration: InputDecoration(labelText: "Your Name")),
                    TextField(
                        controller: controller.myEmail,
                        decoration: InputDecoration(labelText: "Your Email")),
                    TextField(
                        controller: controller.myPassword,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "password")),
                    ElevatedButton(
                      child: Text("Create my user"),
                      onPressed: () async {
                        if (controller.validateForm()) {
                          controller.registerUser();
                        }
                      },
                    ),
                    SizedBox(
                      height: 130,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Already registered?',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Log in here',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back()),
                        ],
                      ),
                    ),
                  ]),
            ),
          ));
    }));
  }
}
