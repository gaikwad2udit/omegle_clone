import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class states with ChangeNotifier {
  bool ischatrandom = false;
  bool isstore = false;
  bool isdashborad = true;
  bool istesting = false;
  void setall() {
    ischatrandom = false;
    isstore = false;
    isdashborad = false;
    istesting = false;
    //notifyListeners();
  }

  void setischatrandom(bool value) {
    ischatrandom = value;

    notifyListeners();
  }

  void setisstore(bool value) {
    isstore = value;
    notifyListeners();
  }

  void setisdashboard(bool value) {
    isdashborad = value;
    notifyListeners();
  }

  void setistesting(bool value) {
    istesting = value;
    notifyListeners();
  }

  bool get getvalue {
    return ischatrandom;
  }

  bool get getisdashboard {
    return isdashborad;
  }

  bool get getvalueofstore {
    return isstore;
  }

  bool get getvalueogtesting {
    return istesting;
  }
}
