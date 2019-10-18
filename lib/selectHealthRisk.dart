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
import 'main.dart';
class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key, @required this.healthRisk, @required this.selectHealthRisk, @required this.healthRisks})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final ValueChanged<int> selectHealthRisk;

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        new Text('Choose the symptom', style: new TextStyle(fontSize: 25.0)),
        children: healthRisks.map((item) => ListTile(
            title: Text(item.name),
            leading: Radio(
              value: item.id,
              groupValue: healthRisk,
              onChanged: (int value) {
                selectHealthRisk(value);
              },
            ),
          )).toList()
      ),
    );
  }
}
