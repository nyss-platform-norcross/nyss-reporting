import 'package:flutter/material.dart';
import 'package:nyss_reporting/errorTextField.dart';
import 'main.dart';
import 'outlineButton.dart';

class MyStatefulWidget extends StatelessWidget {
  MyStatefulWidget(
      {Key key,
      @required this.healthRisk,
      @required this.healthRisks,
      @required this.state,
      @required this.nextStep})
      : super(key: key);

  final int healthRisk;
  final List<HealthRisk> healthRisks;
  final FormFieldState<int> state;
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
                          this.state.didChange(value);
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
        Row(children: <Widget>[
          Visibility(
            visible: this.state.hasError,
            child: StyledErrorTextField(
              title: state.errorText,
              color: RED,
            ),
          )
        ],)
      ]),
    ));
  }
}
