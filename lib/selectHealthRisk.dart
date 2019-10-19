import 'package:flutter/material.dart';
import 'main.dart';
class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key, @required this.healthRisk, @required this.selectHealthRisk, @required this.healthRisks, @required this.nextStep})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final ValueChanged<int> selectHealthRisk;
  final Function nextStep;


  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Column(children: healthRisks.map((item) => ListTile(
            title: Text(item.name),
            leading: Radio(
              value: item.id,
              groupValue: healthRisk,
              onChanged: (int value) {
                selectHealthRisk(value);
              },
            ),
          )).toList()),
          Row(children: <Widget>[
            RaisedButton(
              child: Text('Next'),
              onPressed: nextStep,
            ),
          ])
        ]
      ),
    );
  }
}
