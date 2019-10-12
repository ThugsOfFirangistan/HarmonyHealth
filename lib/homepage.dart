import 'package:flutter/material.dart';
import 'package:harmony/imageScanner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Harmony Health"),
      ),
        body:  Container(
          width: 100,
          height: 100,
          child: OutlineButton(
            child: Text("Click  here"),

            ),
        )
      )
    );
  }
}