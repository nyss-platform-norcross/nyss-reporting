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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(200, 192, 192, 192),
          title: Text('Health Risk App'),
          bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.red),
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







/* class _AppBarSampleState extends State<AppBarSample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Android Monks'),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () {
                _nextPage(1);
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TabPageSelector(controller: _tabController),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

// void main() {
 // runApp(AppBarSample());
// } */