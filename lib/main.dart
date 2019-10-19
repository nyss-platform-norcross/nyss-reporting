import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nyss_reporting/errorTextField.dart';
import 'package:nyss_reporting/numberOfPeople.dart';
import "selectHealthRisk.dart";
import 'package:http/http.dart' as http;
import "peopleCounter.dart";
import "sendSMS.dart";

const String URLHealthRisks =
    "https://nyss-codeathon-brussels.azurewebsites.net/api/HealthRisks/";
const String URL = "https://reportingappbackendrc.herokuapp.com/";

const Color RED = Color.fromARGB(200, 192, 44, 4);
const Color GREY = Color.fromARGB(255, 245, 245, 245);

class VisibilityExample extends StatefulWidget {
  @override
  _VisibilityExampleState createState() {
    return _VisibilityExampleState();
  }
}

class _VisibilityExampleState extends State
    with SingleTickerProviderStateMixin {
  int _selectedHealthRisk = 0;
  TabController _tabController;

  List<String> phoneNumbers = ["+32000000000"];
  List<HealthRisk> healthRisks = new List<HealthRisk>();

  NumberOfPeople _numberOfPeople = new NumberOfPeople();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getThingsOnStartup();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _numberOfPeople.maleUnder5 = 0;
    _numberOfPeople.male5OrOlder = 0;
    _numberOfPeople.female5OrOlder = 0;
    _numberOfPeople.femaleUnder5 = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void addMaleUnderFive() {
    setState(() {
      _numberOfPeople.maleUnder5 += 1;
    });
  }

  void addMaleOverFive() {
    setState(() {
      _numberOfPeople.male5OrOlder += 1;
    });
  }

  void addFemaleUnderFive() {
    setState(() {
      _numberOfPeople.femaleUnder5 += 1;
    });
  }

  void addFemaleOverFive() {
    setState(() {
      _numberOfPeople.female5OrOlder += 1;
    });
  }

  void decrementMaleUnderFive() {
    if (_numberOfPeople.maleUnder5 == 0) {
      return;
    }
    setState(() {
      _numberOfPeople.maleUnder5 -= 1;
    });
  }

  void decrementMaleOverFive() {
    if (_numberOfPeople.male5OrOlder == 0) {
      return;
    }
    setState(() {
      _numberOfPeople.male5OrOlder -= 1;
    });
  }

  void decrementFemaleUnderFive() {
    if (_numberOfPeople.femaleUnder5 == 0) {
      return;
    }
    setState(() {
      _numberOfPeople.femaleUnder5 -= 1;
    });
  }

  void decrementFemaleOverFive() {
    if (_numberOfPeople.female5OrOlder == 0) {
      return;
    }
    setState(() {
      _numberOfPeople.female5OrOlder -= 1;
    });
  }

  void nextStep() {
    if (!_formKey.currentState.validate()) return;

    final int newIndex = _tabController.index + 1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  void previousStep() {
    final int newIndex = _tabController.index - 1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  void _selectHealthRisk(int selectedHealthRisk) {
    setState(() {
      _selectedHealthRisk = selectedHealthRisk;
    });
  }

  bool validateNumberOfPeople(NumberOfPeople value) {
    return (value.male5OrOlder > 0) |
        (value.maleUnder5 > 0) |
        (value.femaleUnder5 > 0) |
        (value.female5OrOlder > 0);
  }

  void sendSms() {
    if (_formKey.currentState.validate()) {
      // TODO: add toast message
      return;
    }
    String response =
        '$_selectedHealthRisk#$_numberOfPeople.maleUnder5#$_numberOfPeople.male5OrOlder#$_numberOfPeople.femaleUnder5#$_numberOfPeople.female5OrOlder';
    SMSUtility.sendSMS(response, phoneNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Risk App',
      theme: ThemeData(
        brightness: Brightness.light,
        toggleableActiveColor: RED,
      ),
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(200, 192, 44, 4),
              title: Text('Health Risk App'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      accentColor: Color.fromARGB(200, 245, 245, 245)),
                  child: Container(
                    height: 48.0,
                    alignment: Alignment.center,
                    child: TabPageSelector(controller: _tabController),
                  ),
                ),
              )),
          body: TabBarView(controller: _tabController, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyStatefulWidget(
                  healthRisk: _selectedHealthRisk,
                  selectHealthRisk: _selectHealthRisk,
                  healthRisks: healthRisks,
                  nextStep: nextStep),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: FormField(
                    initialValue: _numberOfPeople,
                    builder: (FormFieldState<NumberOfPeople> state) {
                      return PeopleCounter(
                          numberOfPeople: _numberOfPeople,
                          state: state,
                          addMaleUnderFive: addMaleUnderFive,
                          addMaleOverFive: addMaleOverFive,
                          addFemaleUnderFive: addFemaleUnderFive,
                          addFemaleOverFive: addFemaleOverFive,
                          decrementMaleUnderFive: decrementMaleUnderFive,
                          decrementMaleOverFive: decrementMaleOverFive,
                          decrementFemaleUnderFive: decrementFemaleUnderFive,
                          decrementFemaleOverFive: decrementFemaleOverFive,
                          sendSms: sendSms,
                          previousStep: previousStep);
                    },
                    validator: (value) {
                      if (validateNumberOfPeople(value)) {
                        return 'Please add a case to report';
                      }
                      return null;
                    },
                  ),
                ))
          ])),
    );
  }

  void _getThingsOnStartup() {
    http.read('${URL}phoneNumbers').then((value) {
      setState(() {
        phoneNumbers = jsonDecode(value)
            .map<String>((n) => Phone.fromJson(n).number)
            .toList();
      });
    });
    http.read(URLHealthRisks).then((value) {
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
      id: int.parse(json['code']),
      name: json['displayName'],
    );
  }
}
