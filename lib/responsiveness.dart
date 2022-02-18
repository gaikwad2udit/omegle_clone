// @dart=2.9
import 'package:flutter/material.dart';

class responsiveness extends StatelessWidget {
  const responsiveness({
    Key key,
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  static bool ismobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool istablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width > 850;
  static bool isdesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1100) {
      return desktop;
    } else if (_size.width > 850 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
