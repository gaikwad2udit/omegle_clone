import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class firebaseServices with ChangeNotifier {
  String chatcollectionname = '';
  List<Map<String, dynamic>> listofallsearches = [];

  Future<void> addinsearching() async {
    await FirebaseFirestore.instance
        .collection('searching')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      "time": FieldValue.serverTimestamp(),
      "user": FirebaseAuth.instance.currentUser.uid,
    });
  }

  void indexandsend() async {
    // looking for current index in the list
    // print(listofallsearches);
    int index;
    for (int i = 0; i < listofallsearches.length; i++) {
      if (FirebaseAuth.instance.currentUser.uid ==
          listofallsearches[i]['user']) {
        index = i;
      }
    }

    //even
    if (index % 2 == 0) {
      chatcollectionname = FirebaseAuth.instance.currentUser.uid;
      if (index + 1 < listofallsearches.length) {
        //make a chat available
        //sending both chats

        await FirebaseFirestore.instance
            .collection('chats')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({'usertoconnect': listofallsearches[index + 1]['user']});

        await FirebaseFirestore.instance
            .collection('chats')
            .doc(listofallsearches[index + 1]['user'])
            .set({'usertoconnect': FirebaseAuth.instance.currentUser.uid});
        //deleting from searchlist
        await FirebaseFirestore.instance
            .collection('searching')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .delete();
        await FirebaseFirestore.instance
            .collection('searching')
            .doc(listofallsearches[index + 1]['user'])
            .delete();
        //this can be buggy in future
        await FirebaseFirestore.instance
            .collection('allchats')
            .doc(chatcollectionname)
            .collection('chat')
            .add({
          'text': 'dummy',
          'time': Timestamp.now(),
          'user': chatcollectionname
        });
      }
    } //odd
    else {
      chatcollectionname = listofallsearches[index - 1]['user'];
      // connecting users
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({'usertoconnect': listofallsearches[index - 1]['user']});

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(listofallsearches[index - 1]['user'])
          .set({'usertoconnect': FirebaseAuth.instance.currentUser.uid});

      //deleting from searchinglist
      await FirebaseFirestore.instance
          .collection('searching')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('searching')
          .doc(listofallsearches[index - 1]['user'])
          .delete();

      // await FirebaseFirestore.instance
      //     .collection('connection')
      //     .doc(chatcollectionname)
      //     .set({'connection': true});
      await FirebaseFirestore.instance
          .collection('allchats')
          .doc(chatcollectionname)
          .collection('chat')
          .add({
        'text': 'dummy',
        'time': Timestamp.now(),
        'user': chatcollectionname,
      });
    }
  }

  Map<String, dynamic> getfixeddata(Map<String, dynamic> element) {
    Map<String, dynamic> time = {};
    Map<String, String> user = {};
    Map<String, dynamic> result = {};

    element.forEach((key, value) {
      if (key == 'user') {
        user.addAll({key: value});
      } else {
        time.addAll({'time': value});
      }
    });

    result.addAll(user);
    result.addAll(time);
    return result;
  }

  Future<void> fetchsearchingdata() async {
    listofallsearches.clear();

    await FirebaseFirestore.instance
        .collection('searching')
        .orderBy('time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        listofallsearches.add(getfixeddata(element.data()));
      });
    });

    indexandsend();
  }

  void sendmessage(String controller) async {
    await FirebaseFirestore.instance
        .collection('allchats')
        .doc(chatcollectionname)
        .collection('chat')
        .add({
      'text': controller,
      'time': Timestamp.now(),
      'user': FirebaseAuth.instance.currentUser.uid,
    });
  }

  void clearconnection() async {
    // await FirebaseFirestore.instance
    //     .collection('connection')
    //     .doc(chatcollectionname)
    //     .update({'connection': false});

    await FirebaseFirestore.instance
        .collection('allchats')
        .doc(chatcollectionname)
        .collection('chat')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatlistner() {
    return FirebaseFirestore.instance
        .collection('allchats')
        .doc(chatcollectionname)
        .collection('chat')
        .orderBy('time')
        .snapshots();
  }
}
