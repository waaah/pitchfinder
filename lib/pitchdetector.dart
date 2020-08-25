import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Pitchdetector {
  static const MethodChannel _channel = const MethodChannel('pitchdetector');
  static StreamController<Object> _recorderController = StreamController<Object>();
  
  
  Stream<Object> get onRecorderStateChanged => _recorderController.stream;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> recordingCallback() async {}

  startRecording() async {
    try {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
      var result = await _channel.invokeMethod('startRecording');
      // if (_recorderController == null) {
      //   _recorderController = new StreamController.broadcast();
      // }
      _channel.setMethodCallHandler((MethodCall call) {
        switch (call.method) {
          case "getPitch":
            if (_recorderController != null) {
              print(call.arguments);
              _recorderController.add(call.arguments);
            } else {
              print("Is not null");
            }
            break;
          default:
            throw new ArgumentError("Unknown method: ${call.method}");
        }
        return null;
      });
      return result;
    } catch (ex) {
      print(ex);
    }
  }
}
