import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import "peopleCounter.dart";
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

  // TODO: State for the select people widget
  num _maleUnderFive = 0;
  num _maleOverFive = 0;
  num _femaleUnderFive = 0;
  num _femaleOverFive = 0;

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
      title: 'Health Risk App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Health Risk App'),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: _isVisible,
                    child: MyStatefulWidget(
                        healthRisk: _healthRisk,
                        selectHealthRisk: _selectHealthRisk)),
                Visibility(
                  visible: !_isVisible,
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
                    decrementFemaleOverFive: decrementFemaleOverFive,
                    sendSms: sendSms
                  ),
                ),
                RaisedButton(
                  child: Text('Next'),
                  onPressed: showToast,
                ),
              ],
            ),
          )),
    );
  }
}

void main() => runApp(VisibilityExample());
