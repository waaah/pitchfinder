import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Pitchdetector {
  static const MethodChannel _channel = const MethodChannel('pitchdetector');
  static StreamController<Object> _recorderController = StreamController<Map<String , Object>>.broadcast();
  bool _isRecording = false;
  
  Stream<Map<String , Object>> get onRecorderStateChanged => _recorderController.stream;
  bool get isRecording => _isRecording;

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
      _isRecording = true;
      _channel.setMethodCallHandler((MethodCall call) {
        switch (call.method) {
          case "getPitch":
            if (_recorderController != null) {
              print(call.arguments);
              _recorderController.add({
                "pitch" : call.arguments,
              });
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

  stopRecording() async{
    _isRecording = false;
    await _channel.invokeMethod('stopRecording');
  }
}
