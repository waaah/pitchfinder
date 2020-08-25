import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pitchdetector/pitchdetector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Pitchdetector detector;
  @override
  void initState() {
    super.initState();
    detector =  new Pitchdetector();
    detector.onRecorderStateChanged.listen((event) {
      print("Event" + event.toString());
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
              onPressed: startRecording, child: Text("Press Me to start")),
        ),
      ),
    );
  }

  void startRecording()  async{
    await detector.startRecording();
   
  }
}
