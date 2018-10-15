
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_location/flutter_native_location.dart';

class LastKnownLocation extends StatelessWidget{
  final Location location;

  LastKnownLocation({
    this.location
  });

  @override
  Widget build(BuildContext context) {
    location.stopListening();
    return WillPopScope(
      onWillPop: onWillPopScope,
      child: Scaffold(
        body: _locationPermissionUi(context)
      )
    );
  }

  Future<bool> onWillPopScope(){
    location.startListening(
      onLocationRecieved: (locationResult){
        print(locationResult);
      }
    );
    return Future.value(true);
  }

  Widget _locationPermissionUi(BuildContext context) => FutureBuilder<PermissionState>(
    future: Permit.checkLocationPermission(context),
    builder: (BuildContext context, AsyncSnapshot<PermissionState> snapshot){
      if(snapshot.hasData){
        if(snapshot.data == PermissionState.DENIED) {
          return _containerWrapper(content: Text("Permission Denied", textAlign: TextAlign.center));
        }
        return _lastKnownLocation();
      }
      return Container(
        padding: new EdgeInsets.all(25.0),
        child: LinearProgressIndicator()
      );
    }
  );

  Widget _lastKnownLocation(){
    // Location location = new Location();
    return FutureBuilder<dynamic>(
      future: location.getLastKnownLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          if(snapshot.data["latitude"].toString() == "error") {
            return _containerWrapper(content: Text("Error: ${snapshot.data["message"].toString()}", textAlign: TextAlign.center));
          }
          print(snapshot.data);
          return _locationResult(
            lng: snapshot.data["longitude"].toString(), 
            lat: snapshot.data["latitude"].toString()
          );
        }
        return _containerWrapper(content: LinearProgressIndicator());
      },
    );
  }


  Widget _containerWrapper({@required Widget content}) => Container(
    padding: new EdgeInsets.all(25.0),
    child: content
  );

  Widget _locationResult({@required String lng, @required String lat}) => Center(
    child: _containerWrapper(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Longitude: $lng", textAlign: TextAlign.center),
          Text("Latitude: $lat", textAlign: TextAlign.center),
        ]
      )
    ),
  );


}