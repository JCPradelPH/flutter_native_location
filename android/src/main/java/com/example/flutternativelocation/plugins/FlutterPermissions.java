package com.example.flutternativelocation.plugins;

import android.app.Activity;
import android.content.IntentSender;
import android.content.pm.PackageManager;
import android.location.Location;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.example.flutternativelocation.utils.Globals;
import com.example.flutternativelocation.utils.LocationInstance;

import java.util.ArrayList;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FlutterPermissions implements LocationInstance.LocationInstanceListener {

    private static final String ARG_KEY = "perm";
    private Activity act;
    private MethodChannel.Result result;
    private MethodCall call;
    private FlutterPermissions instance;
    public static LocationInstance locationInstance;

    public FlutterPermissions(Activity act, BinaryMessenger messenger){
        this.act = act;
        this.instance = this;
        locationInstance = new LocationInstance(act, locationRequest());
        locationInstance.setLocationInstanceListener(this);
        initMethodChannel(messenger);
    }

    private void initMethodChannel(BinaryMessenger messenger){
        new MethodChannel(messenger, Globals.PERMISSION_MC)
                .setMethodCallHandler(methodCallHandler());
    }

    private MethodChannel.MethodCallHandler methodCallHandler(){
        return new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, final MethodChannel.Result result) {

                instance.result = result;
                instance.call = call;

                if (call.method.equals(Globals.PERM_METHOD)) {
                    hasPlatformPermission(Globals.PERM_REQUEST_ID);
                }

                if (call.method.equals(Globals.PERM_LOCATION)) {
                    locationInstance.displayLocationSettingsRequest();
                }
            }
        };
    }

    private LocationRequest locationRequest(){
        return LocationRequest.create().setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
    }

    public void updatePermissionStatus(int status){
        result.success(status);
    }

    public void hasPlatformPermission(int reqId) {
        ArrayList<String> args = call.argument(ARG_KEY);
        String[] permissionsList = new String[args.size()];
        for(int i = 0; i < args.size(); i++) permissionsList[i] = args.get(i);
        if (!hasGrantedAllPerms(permissionsList)) {
            ActivityCompat.requestPermissions(act, permissionsList, reqId);
        } else {
            result.success(Globals.PERMISSION_GRANTED);
        }
    }


    private boolean hasGrantedAllPerms(String[] permissionsList){
        boolean allPermsAllowed = true;
        for(int i = 0; i < permissionsList.length; i++){
            if(ContextCompat.checkSelfPermission(act, permissionsList[i]) !=
                    PackageManager.PERMISSION_GRANTED) allPermsAllowed = false;
        }
        return allPermsAllowed;
    }

    public boolean hasGrantResults(int[] grantResults){
        boolean allPermsAllowed = true;
        for(int i = 0; i < grantResults.length; i++){
            if(grantResults[i] !=
                    PackageManager.PERMISSION_GRANTED) allPermsAllowed = false;
        }
        return allPermsAllowed;
    }

    @Override
    public void onLocationSettingsResponseSuccess() {
        try{
            result.success(Globals.PERMISSION_GRANTED);
        } catch(IllegalStateException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onLocationSettingsResponseFailed(ResolvableApiException resolvable) throws IntentSender.SendIntentException {
        resolvable.startResolutionForResult(act, Globals.LOC_REQUEST_ID);
    }

    @Override
    public void onLastKnownLocationReceived(Location locationResult) {

    }

    @Override
    public void onLocationReceived(LocationResult locationResult) {

    }

    @Override
    public void onNoPermissionGranted() {

    }
}
