import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import "screens/selectHealthRisk.dart";
import "screens/peopleCounter.dart";
import "utils/sendSMS.dart";
import "utils/AppUtils.dart";
import "types/PhoneType.dart";
import 'types/HealthRisk.dart';

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State  with SingleTickerProviderStateMixin {
  int _selectedHealthRisk = 0;
  TabController _tabController;

  List<String> phoneNumbers = ["+32000000000"];
  List<HealthRisk> healthRisks = new List<HealthRisk>();

  num _maleUnderFive = 0;
  num _maleOverFive = 0;
  num _femaleUnderFive = 0;
  num _femaleOverFive = 0;

  @override
  void initState() {
    _getThingsOnStartup();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

   @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  void nextStep() {
    final int newIndex = _tabController.index + 1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

   void previousStep() {
    final int newIndex = _tabController.index -1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
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
      title: 'Health Risk App',
      theme: ThemeData(
        brightness: Brightness.light,
        toggleableActiveColor: AppUtils.RED,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppUtils.RED,
          title: Text('Health Risk App'),
          bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: AppUtils.GREY),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: TabPageSelector(controller: _tabController),
            ),
          ),
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyStatefulWidget(
              healthRisk: _selectedHealthRisk,
              healthRisks: healthRisks,
              selectHealthRisk: _selectHealthRisk,
              nextStep: nextStep
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
              sendSms: sendSms,
              previousStep: previousStep
            ),
          ),
        ]
      )
    ),
  );
}

void _getThingsOnStartup() {
  http
    .read('${AppUtils.URL}phoneNumbers')
    .then((value) {
      setState(() {
        phoneNumbers = jsonDecode(value).map<String>((n) => Phone.fromJson(n).number).toList();
      });
    });
  http
    .read(AppUtils.URLHealthRisks)
    .then((value) {
      setState(() {
        healthRisks = jsonDecode(value).map<HealthRisk>((n) => HealthRisk.fromJson(n)).toList();
      });
    });
  }
}

void main() => runApp(VisibilityExample());
