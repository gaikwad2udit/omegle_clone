import 'package:flutter/material.dart';

class waitaing_screen extends StatelessWidget {
  const waitaing_screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Center(
              child: Text("loading"),
            )
          ],
        ),
      )),
    );
  }
}
