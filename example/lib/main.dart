import 'package:flutter/material.dart';
import 'package:flutter_native_location_example/location/streamed_location.dart';

void main() => runApp(new MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamedLocation()
    );
  }
}
