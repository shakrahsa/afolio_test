import 'package:afolio06/markets/controllers/markets_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'add_market_dialog.dart';

class MarketsView extends StatelessWidget {
  final controller = Get.put(MarketsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 9, // you can play with this value, by default it is 1
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Center(
                    child: Text(
                      'Markets List',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.add_business),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddMarketDialog(),
                  );
                },
              ),
            ),
          ],
        ),
        Container(
            width: double.infinity,
            //height: SizeConfig.screenHeight,
            color: Colors.white,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('MARKETS').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot<Object?>? documentSnapshot =
                            snapshot.data?.docs[index];
                        return Dismissible(
                            key: Key(index.toString()),
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                leading: Icon(Icons.checklist),
                                enabled: true,
                                title: Text((documentSnapshot != null)
                                    ? (documentSnapshot["marketName"])
                                    : ""),
                                trailing: Wrap(
                                  spacing: 12, // space between two icons
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Colors.orange,
                                      onPressed: () {},
                                    ), // icon-1
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {},
                                    ), // icon-2
                                  ],
                                ),
                              ),
                            ));
                      });
                } else {
                  return Text('Something went wrong');
                }
              },
            ))
      ],
    );
  }
}
