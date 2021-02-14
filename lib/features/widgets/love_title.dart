import 'package:flutter/material.dart';

class LoveTitle extends StatefulWidget {
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
}
