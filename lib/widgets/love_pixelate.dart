import 'package:flutter/material.dart';

class LovePixelate extends StatefulWidget {
  final Color color;

  const LovePixelate({Key key, @required this.color}) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width <= 1200;
  }

  @override
  _LovePixelateState createState() => _LovePixelateState();
}

class _LovePixelateState extends State<LovePixelate> {
  double _pixelSize() {
    if (LovePixelate.isSmallScreen(context)) {
      return 30.0;
    } else if (LovePixelate.isMediumScreen(context)) {
      return 40.0;
    } else {
      return 50.0;
    }
  }

  double _borderRadiusSize() {
    if (LovePixelate.isSmallScreen(context)) {
      return 2.5;
    } else if (LovePixelate.isMediumScreen(context)) {
      return 5.0;
    } else {
      return 7.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadiusSize()),
        color: widget.color,
      ),
      child: SizedBox(
        width: _pixelSize(),
        height: _pixelSize(),
        // child: Container(
        //   color: widget.color,
        // ),
      ),
    );
  }
}
