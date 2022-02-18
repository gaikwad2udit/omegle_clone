import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:provider/provider.dart';
import 'package:webui/containers/random_chat_components/controlbutton.dart';

import 'package:webui/responsiveness.dart';
import 'package:webui/services/buttonstate.dart';
import 'package:webui/services/firebaseServices.dart';
import 'package:webui/services/states.dart';

class chat_layout extends StatefulWidget {
  //const chat_layout({ Key? key }) : super(key: key);

  @override
  _chat_layoutState createState() => _chat_layoutState();
}

class _chat_layoutState extends State<chat_layout> {
  String chatuid = '';
  bool isconnected = false;
  var textcontroller = TextEditingController();
  bool isdisconnectpressed = false;
  int currentsize = 0;
  int previoussize = 0;
  int temp = 0;
  int currentdocsize = 0;
  int previoudocssize = 0;
  List<Map<String, String>> localdata1 = [];

  void futurefirebseservices() async {
    await Provider.of<firebaseServices>(context, listen: false)
        .addinsearching();
    await Provider.of<firebaseServices>(context, listen: false)
        .fetchsearchingdata();
    chatuid = Provider.of<firebaseServices>(context, listen: false)
        .chatcollectionname;
    setState(() {
      isconnected = true;
    });
  }

  void connection() async {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection('allchats')
        .doc(chatuid)
        .snapshots();
    stream.forEach((element) {
      print(element.data().values);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(chatuid);
    return Container(
      height: size.height * .87,
      width: size.width,
      child: Column(
        children: [
          Expanded(
              flex: 7,
              child: Container(
                  color: Color.fromARGB(255, 123, 135, 145),
                  //container chat and information
                  child: isconnected
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('allchats')
                              .doc(chatuid)
                              .collection('chat')
                              .orderBy('time', descending: true)
                              .snapshots(),
                          builder: (context, chatSnapshot) {
                            if (!chatSnapshot.hasData) {
                              return Center(child: Text('loding'));
                            }

                            if (chatSnapshot.hasData) {
                              // print('have data');

                            }
                            if (chatSnapshot.hasError) {
                              // print('error');
                              return Center(child: Text('loding'));
                            }
                            final doc = chatSnapshot.requireData;
                            currentsize = doc.size;
                            //user notified that the user is connected
                            if (currentsize < previoussize) {
                              print("yoyooyoyoyoyoyooy");
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Provider.of<buttonstate>(context, listen: false)
                                    .setgreen(true);
                                //        setState(() {
                                //   isconnected = false;
                                // });
                              });

                              isdisconnectpressed = false;
                            }
                            previoussize = currentsize;
                            if (chatSnapshot.connectionState ==
                                ConnectionState.none) {
                              // print(' no value');
                            }
                            if (chatSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              // print("waiting");
                              return Center(child: Text('loding'));
                            } else {
                              if (doc.size > 0 && !isdisconnectpressed) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Provider.of<buttonstate>(context,
                                          listen: false)
                                      .setred(true);
                                });
                              }

                              currentdocsize = doc.size;
                              if (currentdocsize >= previoudocssize) {
                                localdata1.clear();
                                doc.docs.forEach((element) {
                                  localdata1.add({
                                    'user': element['user'],
                                    'text': element['text']
                                  });
                                });
                              }

                              /// working on chat messages to stay after disconnect button
                              previoudocssize = currentdocsize;

                              return Container(
                                child: ListView.builder(
                                  reverse: true,
                                  itemCount: localdata1.length,
                                  itemBuilder: (context, index) {
                                    if (!(localdata1[index]['text'] ==
                                        'dummy')) {
                                      return Row(
                                        children: [
                                          localdata1[index]['user'] ==
                                                  FirebaseAuth
                                                      .instance.currentUser.uid
                                              ? const Text(
                                                  'Me -',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 0, 49, 88)),
                                                )
                                              : const Text(
                                                  'stranger -',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 121, 3, 3)),
                                                ),
                                          Text(
                                            localdata1[index]['text'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text('');
                                    }
                                  },
                                ),
                              );
                            }
                          },
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              child: Text('press to connect'),
                            );
                          },
                        ))),
          Expanded(
              flex: 1,
              child: Container(
                color: Color.fromARGB(255, 73, 72, 65),
                child: Row(
                  children: [
                    //controller button
                    Expanded(
                        flex: !responsiveness.ismobile(context) ? 1 : 2,
                        child: InkWell(
                          hoverColor: Colors.black,
                          onTap: () {
                            if (Provider.of<buttonstate>(context, listen: false)
                                .isgreen) {
                              localdata1.clear();
                              print("first");
                              futurefirebseservices();
                              Provider.of<buttonstate>(context, listen: false)
                                  .setyellow(true);
                              print(Provider.of<buttonstate>(context,
                                      listen: false)
                                  .isyellow);
                              return;
                            }

                            if (Provider.of<buttonstate>(context, listen: false)
                                .isred) {
                              Provider.of<buttonstate>(context, listen: false)
                                  .setgreen(true);

                              Provider.of<firebaseServices>(context,
                                      listen: false)
                                  .clearconnection();
                              chatuid = 'a  ';
                              if (isdisconnectpressed == false) {
                                setState(() {
                                  isdisconnectpressed = true;
                                  // isconnected = false;
                                });
                              }
                              return;
                            }
                          },
                          child: Consumer<buttonstate>(
                            builder: (context, value, child) {
                              Color connectioncolor = Provider.of<buttonstate>(
                                      context,
                                      listen: false)
                                  .connectioncolor;
                              Icon connectionicon = Provider.of<buttonstate>(
                                      context,
                                      listen: false)
                                  .connectionicon;
                              String connectionname = Provider.of<buttonstate>(
                                      context,
                                      listen: false)
                                  .connectionname;

                              return controlbutton(
                                  connectioncolor: connectioncolor,
                                  connectionicon: connectionicon,
                                  connectionname: connectionname);
                            },
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                            color: Color.fromARGB(255, 73, 72, 65),
                            child: isconnected
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          onSubmitted: (newValue) {
                                            if (newValue.isNotEmpty) {
                                              Provider.of<firebaseServices>(
                                                      context,
                                                      listen: false)
                                                  .sendmessage(
                                                      textcontroller.text);
                                              textcontroller.clear();
                                            }
                                          },
                                          controller: textcontroller,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '    enter messages'),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (!textcontroller.text.isEmpty) {
                                              Provider.of<firebaseServices>(
                                                      context,
                                                      listen: false)
                                                  .sendmessage(
                                                      textcontroller.text);
                                              textcontroller.clear();
                                            }
                                          },
                                          icon: Icon(Icons.send_rounded))
                                    ],
                                  )
                                : labalfortext()))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Stack labalfortext() {
    return Stack(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.message), Text("   Enter messages")],
          ),
        )
      ],
    );
  }
}

// return Container(
//                                 child: ListView.builder(
//                                   reverse: true,
//                                   itemCount: doc.size,
//                                   itemBuilder: (context, index) {
//                                     if (!(doc.docs[index]['text'] == 'dummy')) {
//                                       return Row(
//                                         children: [
//                                           doc.docs[index]['user'] ==
//                                                   FirebaseAuth
//                                                       .instance.currentUser.uid
//                                               ? const Text(
//                                                   'Me -',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Color.fromARGB(
//                                                           255, 0, 49, 88)),
//                                                 )
//                                               : const Text(
//                                                   'stranger -',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Color.fromARGB(
//                                                           255, 121, 3, 3)),
//                                                 ),
//                                           Text(
//                                             doc.docs[index]['text'],
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       );
//                                     } else {
//                                       return Text('');
//                                     }
//                                   },
//                                 ),
//                               );
