import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menucontroller extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get Scaffoldkey => _scaffoldkey;
  void controlmenu() {
    if (!_scaffoldkey.currentState.isDrawerOpen) {
      _scaffoldkey.currentState.openDrawer();
    }
  }
}
