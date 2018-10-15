# Flutter Native Location

A demo plugin for Flutter that uses Method and Event Channels to communicate with native Android(Java) and iOS(Swift) code to provide easy access to the platform specific location services.

# This plugin is intended for demo purposes only.

![](https://firebasestorage.googleapis.com/v0/b/github-demo-9415c.appspot.com/o/final.gif?alt=media&token=7e6bec3b-79aa-4a1c-9897-63a262f7d8e7)

## Installing The Plugin
To use this plugin, add it as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  mpa_flutter_libs:    
    git: 
      url: https://github.com/JCPradelPH/flutter_native_location.git
```

### iOS Setup (Make sure you run it on iOS 9 and above.)
Add these lines to your info.plist file
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Flutter Native Location needs to access your location for optimized app experience</string>
	
<key>NSLocationAlwaysUsageDescription</key>
<string>Flutter Native Location needs to access your location for optimized app experience</string>
	
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Flutter Native Location needs to access your location for optimized app experience</string>
  
```
### Android Setup
Add these lines to your Android.manifest file
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

```
### Flutter Usage
For this example, we will first request a permission using a FutureBuilder and then use a StreamBuilder to fetch real-time location updates.

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_location/flutter_native_location.dart';

void main() => runApp(new MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamedLocation()
    );
  }
}

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
```

For help on editing plugin code, view the [documentation](https://flutter.io/developing-packages/#edit-plugin-package).
