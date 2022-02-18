import 'package:flutter/material.dart';

class nv_screen extends StatelessWidget {
  static const routename = "1";
  const nv_screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        color: Colors.greenAccent,
        child: Text("hoi there"),
      ),
    );
  }
}
