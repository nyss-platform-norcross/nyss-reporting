import 'package:flutter/material.dart';
import 'main.dart';

class StyledOutlineButton extends StatelessWidget{
  StyledOutlineButton(
      {Key key,
      @required this.title,
      @required this.onPressed,
      this.outlineColor: RED
      })
      : super(key: key);

  final String title;
  final Color outlineColor;
  final Function onPressed;

  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(title),
      onPressed: onPressed,
      borderSide: BorderSide(
        color: outlineColor,
        style: BorderStyle.solid,
        width: 0.8
      ),
    );
  }
}