import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_location/flutter_native_location.dart';

class StreamedLocation extends StatefulWidget{

  @override
  _State createState() => _State();
}

class _State extends State<StreamedLocation>{

  final Location location = new Location();

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      print("ON DISPOSE");
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Location Demo")
      ),
      body: _locationPermissionUi(context)
    );
  }

  Widget _locationPermissionUi(BuildContext context) => FutureBuilder<PermissionState>(
    future: Permit.checkLocationPermission(context),
    builder: (BuildContext context, AsyncSnapshot<PermissionState> snapshot){
      if(snapshot.hasData){
        if(snapshot.data == PermissionState.DENIED) {
          return Center(child: _containerWrapper(content: Text("Permission Denied", textAlign: TextAlign.center)));
        }
        
        return _streamedLocation();
      }
      return Container(
        padding: new EdgeInsets.all(25.0),
        child: LinearProgressIndicator()
      );
    }
  );

  Widget _streamedLocation(){
    Location location = new Location();
    return StreamBuilder<dynamic>(
      stream: location.snapshots(locationInterval: 5000,numberOfUpdates: 4),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          final result = json.decode(snapshot.data);
          print(result);
          if(result["status"].toString() == "error") {
            return _containerWrapper(content: Text("Error: ${result["message"].toString()}", textAlign: TextAlign.center));
          }
          return _locationResult(
            context,
            lng: result["longitude"].toString(), 
            lat: result["latitude"].toString()
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

  Widget _locationResult(BuildContext context, {@required String lng, @required String lat}) => Center(
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