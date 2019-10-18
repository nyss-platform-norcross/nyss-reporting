import 'dart:convert';

import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import 'package:http/http.dart' as http;
import "sendSMS.dart";

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State {
  bool _isVisible = true;
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

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _selectHealthRisk(String selectedHealthRisk) {
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
                        selectHealthRisk: _selectHealthRisk)),
                Visibility(
                  visible: _isVisible,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('B'),
                      ),
                    ),
                  ),
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
    http.read('https://reportingappbackendrc.herokuapp.com/phoneNumbers').then((value) {
      setState(() {
        phoneNumbers = jsonDecode(value).map<String>((n) => Phone.fromJson(n).number).toList();
      });
    });
    http.read('https://reportingappbackendrc.herokuapp.com/healthRisks').then((value) {
      setState(() {
        healthRisks = jsonDecode(value).map<HealthRisk>((n) => HealthRisk.fromJson(n)).toList();
			});
    });
  }
}

void main() => runApp(VisibilityExample());

class Phone
{
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

class HealthRisk
{
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
