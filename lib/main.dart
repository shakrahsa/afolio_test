import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth/views/loginpage.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';
import 'controllers/global_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(GlobalController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.myapptitle,
      theme: ThemeData( 
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.primaryBg,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
