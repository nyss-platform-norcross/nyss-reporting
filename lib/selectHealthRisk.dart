// Flutter code sample for

// Here is an example of Radio widgets wrapped in ListTiles, which is similar
// to what you could get with the RadioListTile widget.
//
// The currently selected character is passed into `groupValue`, which is
// maintained by the example's `State`. In this case, the first `Radio`
// will start off selected because `_character` is initialized to
// `SingingCharacter.lafayette`.
//
// If the second radio button is pressed, the example's state is updated
// with `setState`, updating `_character` to `SingingCharacter.jefferson`.
// This causes the buttons to rebuild with the updated `groupValue`, and
// therefore the selection of the second button.
//
// Requires one of its ancestors to be a [Material] widget.

import 'package:flutter/material.dart';

class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key, @required this.healthRisk, @required this.selectHealthRisk})
      : super(key: key);

  final String healthRisk;
  final ValueChanged<String> selectHealthRisk;

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Hello'),
            leading: Radio(
              value: "Hello",
              groupValue: healthRisk,
              onChanged: (String value) {
                selectHealthRisk(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Second'),
            leading: Radio(
              value: "Second",
              groupValue: healthRisk,
              onChanged: (String value) {
                selectHealthRisk(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
