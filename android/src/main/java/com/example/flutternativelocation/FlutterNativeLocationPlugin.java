package com.example.flutternativelocation;

import android.content.Intent;

import com.example.flutternativelocation.plugins.FlutterPermissions;
import com.example.flutternativelocation.plugins.LocationAPI;
import com.example.flutternativelocation.utils.Globals;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterNativeLocationPlugin */
public class FlutterNativeLocationPlugin {
  static private FlutterPermissions flutterPermissions;
  static private LocationAPI locationAPI;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    flutterPermissions = new FlutterPermissions(registrar.activity(), registrar.messenger());
    locationAPI = new LocationAPI(registrar.activity(), registrar.messenger());

    registrar.addRequestPermissionsResultListener(new PluginRegistry.RequestPermissionsResultListener() {
      @Override
      public boolean onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {

        if (grantResults.length == 0 || !flutterPermissions.hasGrantResults(grantResults)){
          flutterPermissions.updatePermissionStatus(Globals.PERMISSION_DENIED);
          return false;
        }


        switch (requestCode) {
          case Globals.PERM_REQUEST_ID:
            flutterPermissions.updatePermissionStatus(Globals.PERMISSION_GRANTED);
            break;
          case Globals.LOC_REQUEST_ID:
            flutterPermissions.locationInstance.displayLocationSettingsRequest();
            break;
        }
        return true;
      }
    });

    registrar.addActivityResultListener(new PluginRegistry.ActivityResultListener() {
      @Override
      public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == Globals.LOC_REQUEST_ID) {
          flutterPermissions.updatePermissionStatus(resultCode == 0 ?
                  Globals.PERMISSION_DENIED : Globals.PERMISSION_GRANTED);
        }
        return true;
      }
    });
  }
}
