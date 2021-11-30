import 'package:afolio06/markets/controllers/markets_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMarketDialog extends StatelessWidget {
  final controller = Get.find<MarketsController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Market'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: controller.marketNameController,
              decoration: const InputDecoration(hintText: 'Market Name'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () async {
            if (controller.validateForm()) {
              controller.addMarket();
              controller.marketNameController.clear();
              Get.back();
            }
          },
        ),
      ],
    );
  }
}
