import 'package:flutter/material.dart';

class controlbutton extends StatelessWidget {
  const controlbutton({
    Key key,
    @required this.connectioncolor,
    @required this.connectionname,
    @required this.connectionicon,
  }) : super(key: key);
  final Color connectioncolor;
  final String connectionname;
  final Icon connectionicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: connectioncolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [connectionicon, Text(connectionname)],
      ),
    );
  }
}
