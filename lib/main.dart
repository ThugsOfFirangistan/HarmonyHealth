import 'package:flutter/material.dart';
import 'package:harmony/homepage.dart';

void main() => runApp(Harmony());

class Harmony extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}