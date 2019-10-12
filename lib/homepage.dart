import 'package:flutter/material.dart';
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
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Harmony Health'),
        ),
        body: new Text('Step count: $_stepCountValue'),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.scanner),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => Scanner()));
          },
        ),
      ),
    );
  }
}
