import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import "sendSMS.dart";
import 'validation.dart';

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State {
  bool _healthRiskSelectorVisible = true;
  bool _reportWidgetVisible = false;
  String _healthRisk = "";

  // TODO: State for the select people widget
  num _maleUnderFive = 0;
  num _maleOverFive = 0;
  num _femaleUnderFive = 0;
  num _femaleOverFive = 0;

  // TODO: Get that data from the backend
  List<String> phoneNumbers = [];
  void toggleHealthRiskSelectorVisibility() {
    setState(() {
      _healthRiskSelectorVisible = !_healthRiskSelectorVisible;
    });
  }

  void toggleReportWidgetVisibility() {
    setState(() {
      _reportWidgetVisible = !_reportWidgetVisible;
    });
  }

  void _selectHealthRisk(String healthRisk) {
    setState(() {
      _healthRisk = healthRisk;
    });
  }

  void sendSms() {
    String response =
        'Health Risk: $_healthRisk\nMale under 5: $_maleUnderFive\nMale over five: $_maleOverFive\nFemale under five: $_femaleUnderFive\nFemale over five: $_femaleOverFive';
    SMSUtility.sendSMS(response, phoneNumbers);
  }

  void validateHealthRisk() {
    if (ValidationUtils.healthRiskIsSet(1)) {
      toggleHealthRiskSelectorVisibility();
      toggleReportWidgetVisibility();
    } else {
      // show some error message
    }
  }

  void validateAndSubmit() {
    if (ValidationUtils.healthRiskIsSet(0)) {
      sendSms();
    } else {
      // show some error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyss Reporting',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Nyss Reporting'),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: _healthRiskSelectorVisible,
                    child: MyStatefulWidget(
                        healthRisk: _healthRisk,
                        selectHealthRisk: _selectHealthRisk)),
                Visibility(
                  visible: _reportWidgetVisible,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('B'),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _healthRiskSelectorVisible,
                  child: RaisedButton(
                    child: Text('Next'),
                    onPressed: validateHealthRisk,
                  ),
                ),
                Visibility(
                  visible: _reportWidgetVisible,
                  child: RaisedButton(
                    child: Text('Submit my data'),
                    onPressed: validateAndSubmit,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

void main() => runApp(VisibilityExample());
