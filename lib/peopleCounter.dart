import 'package:flutter/material.dart';
import 'package:nyss_reporting/numberOfPeople.dart';
import 'outlineButton.dart';
import 'main.dart';
class PeopleCounter extends StatelessWidget {
  PeopleCounter(
      {Key key,
      @required this.numberOfPeople,
      @required this.state,
      @required this.addMaleUnderFive,
      @required this.addMaleOverFive,
      @required this.addFemaleUnderFive,
      @required this.addFemaleOverFive,
      @required this.decrementMaleUnderFive,
      @required this.decrementMaleOverFive,
      @required this.decrementFemaleUnderFive,
      @required this.decrementFemaleOverFive,
      @required this.sendSms,
      @required this.previousStep
      })
      : super(key: key);

  final NumberOfPeople numberOfPeople;
  final FormFieldState<NumberOfPeople> state;

  final Function addMaleUnderFive;
  final Function addMaleOverFive;
  final Function addFemaleUnderFive;
  final Function addFemaleOverFive;

  final Function decrementMaleUnderFive;
  final Function decrementMaleOverFive;
  final Function decrementFemaleUnderFive;
  final Function decrementFemaleOverFive;

  final Function sendSms;
  final Function previousStep;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: new Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('Male < 5', style: new TextStyle(fontSize: 25.0)),
              new FloatingActionButton(
                onPressed: addMaleUnderFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text(this.numberOfPeople.maleUnder5.toString(), style: new TextStyle(fontSize: 60.0)),
              new FloatingActionButton(
                onPressed:  decrementMaleUnderFive,
                child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),

            new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('Male >= 5', style: new TextStyle(fontSize: 25.0)),
              new FloatingActionButton(
                onPressed: addMaleOverFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text(numberOfPeople.male5OrOlder.toString(), style: new TextStyle(fontSize: 60.0)),
              new FloatingActionButton(
                onPressed:  decrementMaleOverFive,
                child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),

            new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('Female < 5', style: new TextStyle(fontSize: 25.0)),
              new FloatingActionButton(
                onPressed: addFemaleUnderFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text(numberOfPeople.femaleUnder5.toString(), style: new TextStyle(fontSize: 60.0)),
              new FloatingActionButton(
                onPressed:  decrementFemaleUnderFive,
                child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),

            new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('Female >= 5', style: new TextStyle(fontSize: 25.0)),

              new FloatingActionButton(
                onPressed: addFemaleOverFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text(numberOfPeople.female5OrOlder.toString(), style: new TextStyle(fontSize: 60.0)),
              new FloatingActionButton(
                onPressed:  decrementFemaleOverFive,
                child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StyledOutlineButton(
                title: 'Go back',
                onPressed: previousStep,
                outlineColor: GREY,
              ), 
              StyledOutlineButton(
                title: 'Sybmit my data',
                onPressed: sendSms,
              ),
            ],
          )
        ]
        ),
      )
    );
  }
}
