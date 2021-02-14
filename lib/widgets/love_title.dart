import 'package:flutter/material.dart';

class LoveTitle extends StatefulWidget {
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
  _LoveTitleState createState() => _LoveTitleState();
}

class _LoveTitleState extends State<LoveTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "How lucky is your love life?",
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }

  double _fontSize() {
    if (LoveTitle.isSmallScreen(context)) {
      return 24.0;
    } else {
      return 30.0;
    }
  }
}
