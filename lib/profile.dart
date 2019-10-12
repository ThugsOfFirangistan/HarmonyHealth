import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  height: 0.4 * MediaQuery.of(context).size.height,
                  width: 0.8 * MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    child: Icon(
                      Icons.person,
                      size: 200,
                      color: Colors.blue,
                    ),
                  )),
            ),
            Card(
                shape: StadiumBorder(),
                color: Colors.blue,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Name: Piyush Malviya",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )),
            Card(
                shape: StadiumBorder(),
                color: Colors.red,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Height: 180CM",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )),
            Card(
                shape: StadiumBorder(),
                color: Colors.blue,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Weight: 80KG",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )),
            Card(
                shape: StadiumBorder(),
                color: Colors.red,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Gender: M",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )),
            Card(
                shape: StadiumBorder(),
                color: Colors.blue,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Age: 20",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                )),
          ],
        ));
  }
}
