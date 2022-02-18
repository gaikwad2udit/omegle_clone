import 'package:flutter/material.dart';

class buttonstate with ChangeNotifier {
  bool isgreen = true;
  bool isyellow = false;
  bool isred = false;
  bool isconnected = false;

  void setallfalse() {
    isgreen = false;
    isyellow = false;
    isred = false;
  }

  void setgreen(bool value) {
    setallfalse();
    isgreen = value;
    notifyListeners();
  }

  void setyellow(bool value) {
    setallfalse();
    isyellow = value;
    notifyListeners();
  }

  void setred(bool value) {
    setallfalse();
    isred = value;
    notifyListeners();
  }

  void setisconneted(bool value) {
    isconnected = value;
    notifyListeners();
  }

  Color get connectioncolor {
    if (isgreen) {
      return Colors.green;
    }
    if (isyellow) {
      return Colors.amber;
    }
    if (isred) {
      return Colors.red;
    }
  }

  String get connectionname {
    if (isgreen) {
      return 'connect';
    }
    if (isyellow) {
      return 'connecting';
    }
    if (isred) {
      return 'disconnect';
    }
  }

  Icon get connectionicon {
    if (isgreen) {
      return Icon(Icons.connect_without_contact_rounded);
    }
    if (isyellow) {
      return Icon(Icons.search_rounded);
    }
    if (isred) {
      return Icon(Icons.cancel_rounded);
    }
  }
}
