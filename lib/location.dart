import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_location/Globals.dart';
import 'package:flutter_native_location/plugin_methods.dart';

class Location{

  static const _locationStream = const EventChannel(Globals.locationEC);

  static const _methodChannel = const MethodChannel(Globals.locationMC);

  StreamSubscription _locationSubscription;

  void startListening({@required dynamic onLocationRecieved, int locationInterval = 5000, int numberOfUpdates = 0}){
    assert(onLocationRecieved != null);
    if(_locationSubscription == null){
      _locationSubscription = _locationStream
        .receiveBroadcastStream({
          "locationInterval":locationInterval,
          "numberOfUpdates":numberOfUpdates,
        })
        .listen(onLocationRecieved);
    }
  }

  Stream<dynamic> snapshots({
    int locationInterval = 5000,
    int numberOfUpdates = 0
  }) => _locationStream.receiveBroadcastStream({
      "locationInterval":locationInterval,
      "numberOfUpdates":numberOfUpdates,
    });

  void stopListening(){
    if(_locationSubscription != null){
      _locationSubscription.cancel();
      _locationSubscription = null;
    }
  }

  Future<dynamic> getLastKnownLocation() async {
    try {
      final dynamic result = await _methodChannel.invokeMethod(PluginMethods.getLastKnownLocation);
      return new Future.value(json.decode(result));
    } on PlatformException catch (e) {
      print('Exception ' + e.toString());
    }
    return new Future.value(null);
  }


}