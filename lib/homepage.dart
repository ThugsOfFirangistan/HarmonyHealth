import 'package:flutter/material.dart';
import 'package:harmony/charts.dart';
import 'package:harmony/imageScanner.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';
  double stepcap = 4000;
  double calcount = 0;
  int calcap = 2500;
  int inputcal = 50;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
    setState(() =>
     calcount = calcap-stepCountValue*0.04 );
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text(
            'Harmony Health',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Today",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RadialProgress(
                    goalCompleted: double.parse(_stepCountValue) / stepcap,
                    isWalk: true,),
                Container(
                  width: 50,
                ),
                RadialProgress(
                    goalCompleted:
                        (inputcal - double.parse(_stepCountValue) * 0.04) /
                            calcap,
                            isWalk: false,),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Text('Steps walked: $_stepCountValue',
                      style: TextStyle(fontSize: 15)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Text('Avl. cal for intake: $calcount',
                      style: TextStyle(fontSize: 15)),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.center_focus_strong),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Scanner()));
          },
        ),
      ),
    );
  }
}
