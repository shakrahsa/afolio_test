import 'package:afolio06/markets/views/markets.dart';
import 'package:afolio06/ui/app_bar_widget.dart';
import 'package:afolio06/ui/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'drawer_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context))
            ? Container()
            : AppBarWidget(),
      ),
      drawer: DrawerPage(),
      body: MarketsView(),
      // Test Comment
    );
  }
}
