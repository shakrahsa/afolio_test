import 'package:afolio06/markets/models/markets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class Database extends GetxService {
  FirebaseFirestore databaseReference = FirebaseFirestore.instance;

  Future<void> createMarket(MarketsModel market) async {
    try {
      await databaseReference
          .collection(marketsCollection)
          .doc(market.id)
          .set(market.toJson())
          .then((value) => print("Market Added"));
    } catch (e) {
      debugPrint('Error adding market');
      Get.showSnackbar(GetBar(
        title: 'Error',
        message: 'Error adding market',
        duration: Duration(seconds: 1),
      ));
    }
  }
}
