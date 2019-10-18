import 'dart:convert';

import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import 'package:http/http.dart' as http;
import "peopleCounter.dart";
import "sendSMS.dart";

const String URL = "https://reportingappbackendrc.herokuapp.com/";

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State {
  bool _isVisible = true;
  int _selectedHealthRisk = 0;

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

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _selectHealthRisk(int selectedHealthRisk) {
    setState(() {
      _selectedHealthRisk = selectedHealthRisk;
    });
  }

  void sendSms() {
    String response =
        '$_selectedHealthRisk#$_maleUnderFive#$_maleOverFive#$_femaleUnderFive#$_femaleOverFive';
    SMSUtility.sendSMS(response, phoneNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visibility Tutorial by Woolha.com',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Visibility Tutorial by Woolha.com'),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaisedButton(
                  child: Text('Show/Hide Card B'),
                  onPressed: showToast,
                ),
                Visibility(
                    visible: !_isVisible,
                    child: MyStatefulWidget(
                        healthRisk: _selectedHealthRisk,
                        healthRisks: healthRisks,
                        selectHealthRisk: _selectHealthRisk)),
                Visibility(
                  visible: _isVisible,
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
                RaisedButton(
                  child: Text('Submit my data'),
                  onPressed: sendSms,
                ),
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
