import 'package:flutter/material.dart';
import 'main.dart';
import 'outlineButton.dart';

class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key,
      @required this.healthRisk,
      @required this.healthRisks,
      @required this.selectHealthRisk,
      @required this.nextStep})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final Function selectHealthRisk;
  final Function nextStep;

  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(children: <Widget>[
        Column(
            children: healthRisks
                .map((item) => ListTile(
                      title: Text(item.name),
                      leading: Radio(
                        value: item.id,
                        groupValue: healthRisk,
                        onChanged: (int value) {
                          this.selectHealthRisk(value);
                        },
                      ),
                    ))
                .toList()),
        Row(children: <Widget>[
          StyledOutlineButton(
            title: 'Next',
            onPressed: nextStep,
          ),
        ]),
      ]),
    ));
  }
}
