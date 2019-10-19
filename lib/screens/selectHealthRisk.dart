import 'package:flutter/material.dart';
import '../types/HealthRisk.dart';

class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key,
      @required this.healthRisk,
      @required this.selectHealthRisk,
      @required this.healthRisks})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final ValueChanged<int> selectHealthRisk;

  Widget build(BuildContext context) {
    return Center(
        child: new SingleChildScrollView(
      child: Column(children: <Widget>[
        Column(
            children: healthRisks
                .map((item) => RadioListTile(
                      title: Text(item.name),
                      value: item.id,
                      groupValue: healthRisk,
                      onChanged: (int value) {
                        selectHealthRisk(value);
                      },
                    ))
                .toList()),
      ]),
    ));
  }
}
