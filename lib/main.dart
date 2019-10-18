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
  String _healthRisk = "0";

  @override
  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
    });
    super.initState();
  }

  // TODO: State for the select people widget
  num _maleUnderFive = 0;
  num _maleOverFive = 0;
  num _femaleUnderFive = 0;
  num _femaleOverFive = 0;

  // TODO: Get that data from the backend
  List<String> phoneNumbers = ["+32000000000"];
  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _selectHealthRisk(String healthRisk) {
    setState(() {
      _healthRisk = healthRisk;
    });
  }

  void sendSms() {
    String response =
        '$_healthRisk#$_maleUnderFive#$_maleOverFive#$_femaleUnderFive#$_femaleOverFive';
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
                        healthRisk: _healthRisk,
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
          )
        ),
      );
    }
  Future _getThingsOnStartup() {
    return http.read('http://ip.jsontest.com/').then((value){
    setState(() {
      phoneNumbers = jsonDecode(value);
    });
    });
  }
}

void main() => runApp(VisibilityExample());
