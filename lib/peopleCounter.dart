import 'package:flutter/material.dart';

class PeopleCounter extends StatelessWidget {
  PeopleCounter(
      {Key key,
      @required this.maleUnderFive,
      @required this.maleOverFive,
      @required this.femaleUnderFive,
      @required this.femaleOverFive,
      @required this.addMaleUnderFive,
      @required this.addMaleOverFive,
      @required this.addFemaleUnderFive,
      @required this.addFemaleOverFive,
      @required this.decrementMaleUnderFive,
      @required this.decrementMaleOverFive,
      @required this.decrementFemaleUnderFive,
      @required this.decrementFemaleOverFive,

      })
      : super(key: key);

  final num maleUnderFive;
  final num maleOverFive;
  final num femaleUnderFive;
  final num femaleOverFive;

  final Function addMaleUnderFive;
  final Function addMaleOverFive;
  final Function addFemaleUnderFive;
  final Function addFemaleOverFive;

  final Function decrementMaleUnderFive;
  final Function decrementMaleOverFive;
  final Function decrementFemaleUnderFive;
  final Function decrementFemaleOverFive;



  @override
  Widget build(BuildContext context) {
    return Center(
        child: new Center(
          child: Column(children: <Widget>[
            new Row(
            children: <Widget>[
              new Text('Male < 5', style: new TextStyle(fontSize: 30.0)),
              new FloatingActionButton(
                onPressed: addMaleUnderFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text('$maleUnderFive', style: new TextStyle(fontSize: 60.0)),
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
            children: <Widget>[
              new Text('Male > 5', style: new TextStyle(fontSize: 30.0)),
              new FloatingActionButton(
                onPressed: addMaleOverFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text('$maleOverFive', style: new TextStyle(fontSize: 60.0)),
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
            children: <Widget>[
              new Text('Female < 5', style: new TextStyle(fontSize: 30.0)),
              new FloatingActionButton(
                onPressed: addFemaleUnderFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text('$femaleUnderFive', style: new TextStyle(fontSize: 60.0)),
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
            children: <Widget>[
              new Text('Female > 5', style: new TextStyle(fontSize: 30.0)),

              new FloatingActionButton(
                onPressed: addFemaleOverFive,
                child: new Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              new Text('$femaleOverFive', style: new TextStyle(fontSize: 60.0)),
              new FloatingActionButton(
                onPressed:  decrementFemaleOverFive,
                child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          ]
        ),
      )
    );
  }
}