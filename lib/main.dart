import 'package:flutter/material.dart';
import "selectHealthRisk.dart";
import 'package:http/http.dart' as http;

  class VisibilityExample extends StatefulWidget {
    @override
    _VisibilityExampleState createState() {
      return _VisibilityExampleState();
    }
  }
  
  class _VisibilityExampleState extends State {
    bool _isVisible = true;
    String _healthRisk = "";

  @override
  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
    });
    super.initState();
  }

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
                )
              ],
            ),
          )
        ),
      );
    }
  Future _getThingsOnStartup() async {
    print(await http.read('http://ip.jsontest.com/'));
		}
  }
  
  void main() => runApp(VisibilityExample());