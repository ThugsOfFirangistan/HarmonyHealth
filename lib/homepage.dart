import 'package:flutter/material.dart';
import 'package:harmony/charts.dart';
import 'package:harmony/imageScanner.dart';
import 'package:harmony/profile.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = '0.0';
  double stepcap = 4000;
  double calcount = 0;
  int calcap = 2500;
  String foodcal = '0.0';
  double inputcal = 0.0;
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
    setState(() => calcount = calcap - stepCountValue * 0.04);
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.person, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
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
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RadialProgress(
                  goalCompleted: double.parse(_stepCountValue) / stepcap,
                  isWalk: true,
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Text('Steps walked: $_stepCountValue',
                      style: TextStyle(fontSize: 15)),
                ),
                Container(
                  height: (0.2) * MediaQuery.of(context).size.width,
                ),
                RadialProgress(
                  goalCompleted:
                      (2500 - inputcal - double.parse(_stepCountValue) * 0.04) /
                          calcap,
                  isWalk: false,
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Text('Calories for day: $calcount',
                      style: TextStyle(fontSize: 15)),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.center_focus_strong),
          onPressed: () async {
            foodcal = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => Scanner()));
            setState(() {
              inputcal = inputcal + double.parse(foodcal);
            });
            double netip =
                2500 - inputcal - double.parse(_stepCountValue) * 0.04;
            setState(() {
              calcount = netip;
            });
          },
        ),
      ),
    );
  }
}
