import 'package:afolio06/markets/models/markets_model.dart';
import 'package:afolio06/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class MarketsController extends GetxController {
  final TextEditingController marketNameController = TextEditingController();
  bool validateForm() {
    if (marketNameController.text.length < 3) {
      return false;
    } else {
      return true;
    }
  }

  Future<void>? addMarket() async {
    final MarketsModel market = MarketsModel.fromJson({
      'id': randomNumeric(15),
      'marketName': marketNameController.text,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await Database().createMarket(market);
  }
}
