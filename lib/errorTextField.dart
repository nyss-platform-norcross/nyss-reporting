import 'package:flutter/material.dart';
import 'main.dart';

class StyledErrorTextField extends StatelessWidget{
  StyledErrorTextField(
      {Key key,
      @required this.title,
      this.color: RED
      })
      : super(key: key);

  final String title;
  final Color color;

  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color
      )
    );
  }
}