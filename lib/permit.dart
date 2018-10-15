import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_location/Globals.dart';
import 'package:flutter_native_location/platform_permissions.dart';
import 'package:flutter_native_location/plugin_methods.dart';

class Permit{
  static const _methodChannel = const MethodChannel(Globals.permissionMC);

  static Future<PermissionState> checkPermission(BuildContext context, List<Permissions> permissions) async {
    try {
      if(Theme.of(context).platform == TargetPlatform.iOS){
        bool allPermsAllowed = true;
        for(Permissions perm in permissions){
          final int permResult = await _methodChannel.invokeMethod(
            PlatformPermissions.iosPermissions[perm.index]
          );
          if(PermissionState.values.elementAt(permResult) == PermissionState.DENIED) allPermsAllowed = false;
        }
        return new Future.value(allPermsAllowed ? PermissionState.GRANTED : PermissionState.DENIED);
      }
      List<dynamic> permParams = permissions.map( (perm) => PlatformPermissions.androidPermissions[perm.index] ).toList();
      final int result = await _methodChannel.invokeMethod(PluginMethods.hasPerm,{'perm':permParams});
      return new Future.value(PermissionState.values.elementAt(result));
    } on PlatformException catch (e) {
      print('Exception ' + e.toString());
    }
    return new Future.value(PermissionState.DENIED);
  }

  static Future<PermissionState> checkLocationPermission(BuildContext context) async{
    try {
      if(Theme.of(context).platform == TargetPlatform.iOS){
        final int permResult = await _methodChannel.invokeMethod(
          PluginMethods.hasIosLocationPerm
        );
        return new Future.value(PermissionState.values.elementAt(permResult));
      }
      final int result = await _methodChannel.invokeMethod(PluginMethods.hasAndroidLocationPerm);
      return new Future.value(PermissionState.values.elementAt(result));
    } on PlatformException catch (e) {
      print('Exception ' + e.toString());
    }
    return new Future.value(PermissionState.DENIED);
  }

}

enum PermissionState{
  GRANTED,
  DENIED,
  SHOW_RATIONALE
}

enum Permissions{
  STORAGE, CAMERA
}