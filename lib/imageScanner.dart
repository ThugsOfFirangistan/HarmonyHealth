import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  bool _autoFocusOcr = true;
  bool _torchOcr = false;
  bool _multipleOcr = true;
  bool _waitTapOcr = true;
  bool _showTextOcr = true;
  Size _previewOcr;
  List<OcrText> _textsOcr = [];

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((previewSizes) => setState(() {
          _previewOcr = previewSizes[_cameraOcr].first;
        }));
  }


  List<DropdownMenuItem<int>> _getCameras() {
    List<DropdownMenuItem<int>> cameraItems = [];

    cameraItems.add(new DropdownMenuItem(
      child: new Text('BACK'),
      value: FlutterMobileVision.CAMERA_BACK,
    ));

    cameraItems.add(new DropdownMenuItem(
      child: new Text('FRONT'),
      value: FlutterMobileVision.CAMERA_FRONT,
    ));

    return cameraItems;
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(20),
              child: new Text("Which camera would you like to use?",
                  style: TextStyle(fontSize: 18))),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
            ),
            child: new DropdownButton(
              items: _getCameras(),
              onChanged: (value) {
                _previewOcr = null;
                setState(() => _cameraOcr = value);
              },
              value: _cameraOcr,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: new Text("Please turn on if in low light environemnts.",
                  style: TextStyle(fontSize: 18))),
          SwitchListTile(
            title: const Text('Torch'),
            value: _torchOcr,
            onChanged: (value) => setState(() => _torchOcr = value),
          ),
          Center(
            child: RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              onPressed: _read,
              child: Text(
                "Let's Scan",
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
              elevation: 15,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5 * MediaQuery.of(context).size.height,
                child: Text(name),
              )
          )
        ],
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        flash: _torchOcr,
        autoFocus: _autoFocusOcr,
        multiple: _multipleOcr,
        waitTap: _waitTapOcr,
        showText: _showTextOcr,
        preview: _previewOcr,
        camera: _cameraOcr,
        fps: 2.0,
      );
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;
    setState(
      () => 
      _textsOcr = texts
      );
  }
}