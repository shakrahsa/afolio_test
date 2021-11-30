import 'package:afolio06/auth/models/users_model.dart';
import 'package:afolio06/controllers/global_controller.dart';
import 'package:afolio06/ui/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'registration.dart';
import 'package:get/get.dart';

void _login(String email, String password) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) async {
      String _userId = result.user!.uid;
      await FirebaseFirestore.instance
          .collection('USERS')
          .doc(_userId)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          Get.find<GlobalController>().currentUser.value =
              UsersModel.fromJson(snapshot.data()!);
        }
      });
      //TODO go to home page
      Get.to(HomePage());
    });
  } on FirebaseAuthException catch (error) {
    if (error.code == 'user-not-found') {
      Get.defaultDialog(
          title: 'Error Message', middleText: 'No user found for that email.');
    } else if (error.code == 'wrong-password') {
      Get.defaultDialog(
          title: 'Error Message',
          middleText: 'Wrong password provided for that user.');
    } else {
      Get.defaultDialog(
          title: 'Error Message', middleText: error.message.toString());
    }
  } catch (e) {
    Get.defaultDialog(title: 'Error Message', middleText: e.toString());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final myEmail = TextEditingController();
    final myPassword = TextEditingController();
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
                    Text("Welcome to the app, please log in"),
                    TextField(
                        controller: myEmail,
                        decoration: InputDecoration(labelText: "email")),
                    TextField(
                        controller: myPassword,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "password")),
                    RaisedButton(
                        color: Colors.blue,
                        child: Text("Log in",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          myEmail.text = 'shaya3@shaya.com';
                          myPassword.text = 'Shsh4141\\\\';
                          if (GetUtils.isEmail(myEmail.text)) {
                            _login(myEmail.text, myPassword.text);
                          } else {
                            Get.defaultDialog(
                                title: 'Error Message',
                                middleText:
                                    'Email provided, not a valid email');
                          }
                        }),
                    FlatButton(
                      onPressed: () {
                        //TODO FORGOT PASSWORD SCREEN GOES HERE
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'New User?',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Create Account here',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(RegistrationView())),
                        ],
                      ),
                    ),
                  ]),
            ),
          ));
    }));
  }
}
/*
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final myEmail = TextEditingController();
    final myPassword = TextEditingController();
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('Please sign in: '),
          TextField(
            controller: myEmail,
            decoration: const InputDecoration(labelText: 'Email:'),
          ),
          TextField(
            obscureText: true,
            controller: myPassword,
            decoration: InputDecoration(labelText: 'Password:'),
          ),
          Row(children: <Widget>[
            const SizedBox(width: 50),
            ElevatedButton.icon(
              onPressed: () {
                myEmail.text = 'shaya3@shaya.com';
                myPassword.text = 'Shsh4141\\\\';
                if (GetUtils.isEmail(myEmail.text)) {
                  _login(myEmail.text, myPassword.text);
                } else {
                  Get.defaultDialog(
                      title: 'Error Message',
                      middleText: 'Email provided, not a valid email');
                }
              },
              icon: const Icon(Icons.login_rounded, size: 18),
              label: const Text("Sign In"),
            ),
            const SizedBox(width: 50),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(RegistrationView());
              },
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text("New user - Register here"),
            )
          ]),
        ],
      ),
    );
  }
}

*/
