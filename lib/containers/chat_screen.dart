import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:getwidget/components/loader/gf_loader.dart';

class chat_container extends StatefulWidget {
  @override
  State<chat_container> createState() => _chat_containerState();
}

class _chat_containerState extends State<chat_container> {
  //const chat_container({Key key}) : super(key: key);
  bool ischaton = false;
  String chatcollectionname = '';
  void addinsearching() async {
    await FirebaseFirestore.instance
        .collection('searching')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      "time": FieldValue.serverTimestamp(),
      "user": FirebaseAuth.instance.currentUser.uid,
    });
    // await FirebaseFirestore.instance
    //     .collection('chats')
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .set({'text': 'for first time'});
  }

  List<Map<String, dynamic>> listofallsearches = [];

  void fetchsearchingdata() async {
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

//function for even odd
//lots of bugs can be found here
  void indexandsend() async {
    // looking for current index in the list

    int index;
    for (int i = 0; i < listofallsearches.length; i++) {
      if (FirebaseAuth.instance.currentUser.uid ==
          listofallsearches[i]['user']) {
        index = i;
      }
    }

    //even
    if (index % 2 == 0) {
      setState(() {
        ischaton = true;
      });

      chatcollectionname = FirebaseAuth.instance.currentUser.uid;
      if (index + 1 < listofallsearches.length) {
        //make a chat available
        //sending both chats

        // await FirebaseFirestore.instance
        //     .collection('chats')
        //     .doc(FirebaseAuth.instance.currentUser.uid)
        //     .set({'usertoconnect': listofallsearches[index + 1]['user']});

        // await FirebaseFirestore.instance
        //     .collection('chats')
        //     .doc(listofallsearches[index + 1]['user'])
        //     .set({'usertoconnect': FirebaseAuth.instance.currentUser.uid});
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
            .add({'text': 'dummy', 'time': Timestamp.now()});
      }
    } //odd
    else {
      chatcollectionname = listofallsearches[index - 1]['user'];
      //connecting users
      // await FirebaseFirestore.instance
      //     .collection('chats')
      //     .doc(FirebaseAuth.instance.currentUser.uid)
      //     .set({'usertoconnect': listofallsearches[index - 1]['user']});

      // await FirebaseFirestore.instance
      //     .collection('chats')
      //     .doc(listofallsearches[index - 1]['user'])
      //     .set({'usertoconnect': FirebaseAuth.instance.currentUser.uid});

      //deleting from searchinglist
      await FirebaseFirestore.instance
          .collection('searching')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('searching')
          .doc(listofallsearches[index - 1]['user'])
          .delete();
      await FirebaseFirestore.instance
          .collection('allchats')
          .doc(chatcollectionname)
          .collection('chat')
          .add({
        'text': 'dummy',
        'time': Timestamp.now(),
        'user': chatcollectionname,
      });
      setState(() {
        ischaton = true;
      });
    }
  }

//a function for solving random fields
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

//messaging
  void sendmessage() async {
    await FirebaseFirestore.instance
        .collection('allchats')
        .doc(chatcollectionname)
        .collection('chat')
        .add({
      'text': textcontroller.text,
      'time': Timestamp.now(),
      'user': FirebaseAuth.instance.currentUser.uid,
    });
  }

  void clearconnection() async {
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

    setState(() {
      ischaton = false;
    });
  }

  var textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.grey,
      child: Center(
        child: Column(
          children: [
            if (ischaton == false)
              ElevatedButton(
                child: Text("Connect"),
                onPressed: () async {
                  await addinsearching();
                  await fetchsearchingdata();
                },
              ),
            SizedBox(
              height: 20,
            ),

            if (ischaton)
              Container(
                color: Colors.grey,
                height: 400,
                width: 400,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('allchats')
                      .doc(chatcollectionname)
                      .collection('chat')
                      .orderBy('time')
                      .snapshots(),
                  builder: (ctx, chatSnapshot) {
                    print('yoyoyo');
                    if (!chatSnapshot.hasData) {
                      print('has no data');
                      return Center(
                          child: GFLoader(
                        child: CircularProgressIndicator(),
                      ));
                    }

                    if (chatSnapshot.hasData) {
                      print('have data');
                    }
                    if (chatSnapshot.hasError) {
                      print('error');
                      return Center(child: CircularProgressIndicator());
                    }
                    final doc = chatSnapshot.requireData;

                    if (chatSnapshot.connectionState == ConnectionState.none) {
                      print(' no value');
                    }
                    if (chatSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      print(doc.size);

                      return doc.size > 0
                          ? Container(
                              color: Colors.blueGrey,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: doc.size,
                                      itemBuilder: (context, index) {
                                        if (!(doc.docs[index]['text'] ==
                                            'dummy')) {
                                          return Row(
                                            children: [
                                              doc.docs[index]['user'] ==
                                                      FirebaseAuth.instance
                                                          .currentUser.uid
                                                  ? Text(
                                                      'Me -',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255, 0, 49, 88)),
                                                    )
                                                  : Text(
                                                      'stranger -',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                              // Text(
                                              //   doc.docs[index]['user'] ==
                                              //           FirebaseAuth.instance
                                              //               .currentUser.uid
                                              //       ? "Me  - "
                                              //       : "Stannger  - ",
                                              //   style: TextStyle(
                                              //       color: Color.fromARGB(
                                              //           255, 0, 49, 88)),
                                              // ),
                                              Text(
                                                doc.docs[index]['text'],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Text('');
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                      color: Color.fromARGB(255, 192, 160, 148),
                                      height: 80,
                                      width: 400,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.redAccent),
                                              onPressed: () {},
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.close),
                                                    Text(
                                                      'disconnect',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          // IconButton(
                                          //     onPressed: () async {
                                          //       await clearconnection();
                                          //     },
                                          //     icon: Icon(
                                          //         Icons.exit_to_app_rounded)),
                                          Expanded(
                                            child: TextField(
                                              controller: textcontroller,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "        enter message "),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                if (textcontroller
                                                    .text.isNotEmpty) {
                                                  sendmessage();
                                                  textcontroller.clear();
                                                }
                                              },
                                              icon: Icon(Icons.send_rounded))
                                        ],
                                      )),
                                ],
                              ),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Searching')
                                ],
                              ),
                            ); // work start from here
                    }
                  },
                ),
              )
            // if (ischaton)
          ],
        ),
      ),
    );
  }
}
