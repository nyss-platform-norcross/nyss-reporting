import 'package:flutter/material.dart';
import '../types/HealthRisk.dart';
import '../components/outlineButton.dart';

class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key,
      @required this.healthRisk,
      @required this.selectHealthRisk,
      @required this.healthRisks,
      @required this.state,
      @required this.nextStep})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final ValueChanged<int> selectHealthRisk;
  final FormFieldState<int> state;
  final Function nextStep;

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
                        this.state.didChange(value);
                        selectHealthRisk(value);
                      },
                    ))
                .toList()),
        Row(children: <Widget>[
          StyledOutlineButton(
            title: 'Next',
            onPressed: nextStep,
          ),
        ])
      ]),
    ));
  }
}
