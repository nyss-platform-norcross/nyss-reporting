import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nyss_reporting/types/numberOfPeople.dart';
import 'package:flutter/services.dart';

import "screens/selectHealthRisk.dart";
import "screens/peopleCounter.dart";
import "utils/sendSMS.dart";
import "utils/AppUtils.dart";
import "types/PhoneType.dart";
import 'types/HealthRisk.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  bool limitNumber(int number) {
    if (number >= 20) {
      Fluttertoast.showToast(
          msg: "You have reached the limit!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: AppUtils.RED,
          textColor: Colors.white);
      return true;
    }
    return false;
  }

  void addMaleUnderFive() {
    if (!limitNumber(_numberOfPeople.maleUnder5)) {
      setState(() {
        _numberOfPeople.maleUnder5 += 1;
      });
    }
  }

  void addMaleOverFive() {
    if (!limitNumber(_numberOfPeople.male5OrOlder)) {
      setState(() {
        _numberOfPeople.male5OrOlder += 1;
      });
    }
  }

  void addFemaleUnderFive() {
    if (!limitNumber(_numberOfPeople.femaleUnder5)) {
      setState(() {
        _numberOfPeople.femaleUnder5 += 1;
      });
    }
  }

  void addFemaleOverFive() {
    if (!limitNumber(_numberOfPeople.female5OrOlder)) {
      setState(() {
        _numberOfPeople.female5OrOlder += 1;
      });
    }
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
    final int newIndex = _tabController.index + 1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  void previousStep() {
    setState(() {
      _selectedHealthRisk = 0;
    });
    final int newIndex = _tabController.index - 1;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  void _selectHealthRisk(int selectedHealthRisk) {
    setState(() {
      _selectedHealthRisk = selectedHealthRisk;
    });
    nextStep();
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
    String maleUnder5 = _numberOfPeople.maleUnder5.toString();
    String male5OrOlder = _numberOfPeople.male5OrOlder.toString();
    String femaleUnder5 = _numberOfPeople.femaleUnder5.toString();
    String female5OrOlder = _numberOfPeople.female5OrOlder.toString();

    String response =
        '$_selectedHealthRisk#$maleUnder5#$male5OrOlder#$femaleUnder5#$female5OrOlder';
    SMSUtility.sendSMS(response, phoneNumbers);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
              )),
          body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyStatefulWidget(
                      healthRisk: _selectedHealthRisk,
                      healthRisks: healthRisks,
                      selectHealthRisk: _selectHealthRisk),
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
                              decrementFemaleUnderFive:
                                  decrementFemaleUnderFive,
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
                    )),
              ])),
    );
  }

  void _getThingsOnStartup() {
    http.read('${AppUtils.URL}phoneNumbers').then((value) {
      setState(() {
        phoneNumbers = jsonDecode(value)
            .map<String>((n) => Phone.fromJson(n).number)
            .toList();
      });
    });
    http.read(AppUtils.URLHealthRisks).then((value) {
      setState(() {
        healthRisks = jsonDecode(value)
            .map<HealthRisk>((n) => HealthRisk.fromJson(n))
            .toList();
      });
    });
  }
}

void main() => runApp(VisibilityExample());
