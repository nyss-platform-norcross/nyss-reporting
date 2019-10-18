import 'dart:convert';

import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import 'package:http/http.dart' as http;
import "peopleCounter.dart";
import "sendSMS.dart";
import 'validation.dart';

const String URL = "https://reportingappbackendrc.herokuapp.com/";

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State {
  bool _healthRiskSelectorVisible = true;
  bool _reportWidgetVisible = false;
  String _selectedHealthRisk = "0";

  // TODO: Put here the default number
  List<String> phoneNumbers = ["+32000000000"];
  List<HealthRisk> healthRisks = new List<HealthRisk>();

  // TODO: State for the select people widget
  num _maleUnderFive = 0;
  num _maleOverFive = 0;
  num _femaleUnderFive = 0;
  num _femaleOverFive = 0;

  @override
  void initState() {
    _getThingsOnStartup();
    super.initState();
  }

  void addMaleUnderFive(){
    setState(() {
      _maleUnderFive = _maleUnderFive + 1;
    });
  }
   void addMaleOverFive(){
    setState(() {
      _maleOverFive = _maleOverFive + 1;
    });
  }

 void addFemaleUnderFive(){
    setState(() {
      _femaleUnderFive = _femaleUnderFive + 1;
    });
  }

 void addFemaleOverFive(){
    setState(() {
      _femaleOverFive = _femaleOverFive + 1;
    });
  }


  void decrementMaleUnderFive(){
    if(_maleUnderFive == 0 ){
      return;
    }
    setState(() {
      _maleUnderFive = _maleUnderFive - 1;
    });
  }
   void decrementMaleOverFive(){
     if(_maleOverFive == 0 ){
      return;
    }
    setState(() {
      _maleOverFive = _maleOverFive - 1;
    });
  }

 void decrementFemaleUnderFive(){
   if(_femaleUnderFive == 0 ){
      return;
    }
    setState(() {
      _femaleUnderFive = _femaleUnderFive - 1;
    });
  }

 void decrementFemaleOverFive(){
   if(_femaleOverFive == 0 ){
      return;
    }
    setState(() {
      _femaleOverFive = _femaleOverFive - 1;
    });
  }

  void _selectHealthRisk(String selectedHealthRisk) {
    setState(() {
      _selectedHealthRisk = selectedHealthRisk;
    });
  }

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

  void sendSms() {
    String response =
        '$_selectedHealthRisk#$_maleUnderFive#$_maleOverFive#$_femaleUnderFive#$_femaleOverFive';
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
                        healthRisk: _selectedHealthRisk,
                        selectHealthRisk: _selectHealthRisk)),
                Visibility(
                  visible: _reportWidgetVisible,
                  child: PeopleCounter(
                    maleOverFive: _maleOverFive,
                    maleUnderFive: _maleUnderFive,
                    femaleOverFive: _femaleOverFive,
                    femaleUnderFive: _femaleUnderFive,
                    addMaleUnderFive: addMaleUnderFive,
                    addMaleOverFive: addMaleOverFive,
                    addFemaleUnderFive: addFemaleUnderFive,
                    addFemaleOverFive: addFemaleOverFive,
                    decrementMaleUnderFive: decrementMaleUnderFive,
                    decrementMaleOverFive: decrementMaleOverFive,
                    decrementFemaleUnderFive: decrementFemaleUnderFive,
                    decrementFemaleOverFive: decrementFemaleOverFive
                  )
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

  void _getThingsOnStartup() {
    http
        .read('${URL}phoneNumbers')
        .then((value) {
      setState(() {
        phoneNumbers = jsonDecode(value)
            .map<String>((n) => Phone.fromJson(n).number)
            .toList();
      });
    });
    http
        .read('${URL}healthRisks')
        .then((value) {
      setState(() {
        healthRisks = jsonDecode(value)
            .map<HealthRisk>((n) => HealthRisk.fromJson(n))
            .toList();
      });
    });
  }
}

void main() => runApp(VisibilityExample());

class Phone {
  final String number;
  final String name;

  Phone({this.name, this.number});

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      number: json['number'],
      name: json['name'],
    );
  }
}

class HealthRisk {
  final int id;
  final String name;

  HealthRisk({this.name, this.id});

  factory HealthRisk.fromJson(Map<String, dynamic> json) {
    return HealthRisk(
      id: json['Id'],
      name: json['Name'],
    );
  }
}
