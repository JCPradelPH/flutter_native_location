package com.example.flutternativelocation.plugins;

import android.app.Activity;
import android.content.IntentSender;
import android.location.Location;
import android.util.Log;

import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.example.flutternativelocation.utils.Globals;
import com.example.flutternativelocation.utils.LocationInstance;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocationAPI implements LocationInstance.LocationInstanceListener{

    private Activity activity;
    public static LocationInstance locationInstance;
    private MethodChannel.Result result;
    private EventChannel.EventSink events;

    public LocationAPI(Activity activity, BinaryMessenger messenger) {
        this.activity = activity;
        locationInstance = new LocationInstance(activity, locationRequest(0, 1500));
        locationInstance.setLocationInstanceListener(this);
        initMethodChannel(messenger);
        initEventChannel(messenger);
    }

    private void initMethodChannel(BinaryMessenger messenger){
        new MethodChannel(messenger, Globals.LOCATION_MC).setMethodCallHandler(methodCallHandler());
    }

    private MethodChannel.MethodCallHandler methodCallHandler(){
        return new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, final MethodChannel.Result mresult) {
                Log.e(Globals.TAG,"onMethodCall");
                result = mresult;
                if (call.method.equals(Globals.LOC_METHOD_LAST_KNOWN_LOC)) {
                    String userId = call.argument("userId");
                    locationInstance.getLastKnownLocation();
                }
            }
        };
    }

    private void initEventChannel(BinaryMessenger messenger){
        new EventChannel(messenger, Globals.LOCATION_EC).setStreamHandler(streamHandler());
    }

    private EventChannel.StreamHandler streamHandler(){
        return new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object args, final EventChannel.EventSink mevents) {
                events = mevents;
                try {
                    JSONObject params = new JSONObject(args.toString());
                    int locationInterval = Integer.parseInt(params.get("locationInterval").toString());
                    int numberOfUpdates = Integer.parseInt(params.get("numberOfUpdates").toString());
                    locationInstance.setLocationRequest(locationRequest(numberOfUpdates, locationInterval));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                locationInstance.startLocationUpdates();
            }

            @Override
            public void onCancel(Object args) {
                Log.w(Globals.TAG, "cancelling listener");
            }
        };
    }

    private LocationRequest locationRequest(int numberOfUpdates, int locationInterval){
        LocationRequest mLocationRequest = LocationRequest.create();
        if(numberOfUpdates > 0) mLocationRequest.setNumUpdates(numberOfUpdates);
        return mLocationRequest
                .setInterval(locationInterval)
                .setFastestInterval(locationInterval)
                .setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
    }

    @Override
    public void onLocationSettingsResponseSuccess() {

    }

    @Override
    public void onLocationSettingsResponseFailed(ResolvableApiException resolvable) throws IntentSender.SendIntentException {

    }

    @Override
    public void onLastKnownLocationReceived(Location locationResult) {
        JSONObject jsonObject = new JSONObject();
        try {
            if (locationResult == null) {
                jsonObject.accumulate("status", "error");
                jsonObject.accumulate("message", "No location retrieved");
                result.success(jsonObject.toString());
                return;
            }
            jsonObject.accumulate("status", "success");
            jsonObject.accumulate("longitude", locationResult.getLongitude());
            jsonObject.accumulate("latitude", locationResult.getLatitude());
            result.success(jsonObject.toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onLocationReceived(LocationResult locationResult) {
        JSONObject jsonObject = new JSONObject();
        try {
            if (locationResult == null) {
                jsonObject.accumulate("status", "error");
                jsonObject.accumulate("message", "No location retrieved");
                events.success(jsonObject.toString());
                return;
            }
            for (Location location : locationResult.getLocations()) {
                jsonObject.accumulate("status", "success");
                jsonObject.accumulate("longitude", location.getLongitude());
                jsonObject.accumulate("latitude", location.getLatitude());
            }
            events.success(jsonObject.toString());

        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onNoPermissionGranted() {
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.accumulate("status", "error");
            jsonObject.accumulate("message", "No location permission");
            result.success(jsonObject.toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
