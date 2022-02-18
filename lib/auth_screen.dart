import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class auth_screen extends StatefulWidget {
  const auth_screen({Key key}) : super(key: key);

  @override
  State<auth_screen> createState() => _auth_screenState();
}

class _auth_screenState extends State<auth_screen> {
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    final authuser = FirebaseAuth.instance;

    void anonsignin() async {
      //server timpstamp in seconds precision will get bubby on traffic needs milisecond or nanosecond precision
      await authuser.signInAnonymously();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'user': FirebaseAuth.instance.currentUser.uid,
        'time': FieldValue.serverTimestamp()
      });
    }

    return Scaffold(
      body: Center(
        child: Container(
          // width: size.width * .5,
          // height: size.height * .5,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    anonsignin();
                  },
                  child: Text("Enter anonmously"))
            ],
          ),
        ),
      ),
    );
  }
}
