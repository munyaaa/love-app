import 'package:flutter/material.dart';

class LoveButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const LoveButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          text ?? "",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        color: Color(0xffbb7e69),
      ),
    );
  }
}
