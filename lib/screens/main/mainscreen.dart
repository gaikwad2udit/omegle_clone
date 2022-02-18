import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:webui/constants.dart';
import 'package:webui/controllers/menucontroller.dart';
import 'package:webui/responsiveness.dart';
import 'package:webui/screens/main/components/sidemenu.dart';
import 'package:webui/screens/main/dashboard/dashborad_screen.dart';
import 'package:provider/provider.dart';

class mainscreen extends StatelessWidget {
  static const routename = "mainscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<menucontroller>().Scaffoldkey,
      drawer: sidemenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (responsiveness.isdesktop(context)) Expanded(child: sidemenu()),
          Expanded(flex: 5, child: dashboard_screen()),
        ],
      )),
    );
  }
}
