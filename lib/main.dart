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
    bool _isVisible = true;
    String _healthRisk = "";

    // TODO: State for the select people widget
    num _maleUnderFive = 0;
    num _maleOverFive = 0;
    num _femaleUnderFive = 0;
    num _femaleOverFive = 0;
    
    // TODO: Get that data from the backend
    List<String> phoneNumbers = []; 
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

    void sendSms(){
      String response = 'Health Risk: $_healthRisk\nMale under 5: $_maleUnderFive\nMale over five: $_maleOverFive\nFemale under five: $_femaleUnderFive\nFemale over five: $_femaleOverFive';
      SMSUtility.sendSMS(response, phoneNumbers);
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
                    selectHealthRisk: _selectHealthRisk
                  )
                ),
                Visibility (
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
                  onPressed: validateAndSubmit,
                ),
              ],
            ),
          )
        ),
      );
    }
  }
  
  void main() => runApp(VisibilityExample());