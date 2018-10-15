package com.example.flutternativelocation.utils;

import android.Manifest;
import android.app.Activity;
import android.content.IntentSender;
import android.content.pm.PackageManager;
import android.location.Location;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.util.Log;

import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.SettingsClient;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import com.example.flutternativelocation.utils.Globals;

public class LocationInstance implements OnSuccessListener, OnFailureListener {

    private static Activity activity;
    LocationRequest locationRequest;

    public LocationInstance(Activity activity, LocationRequest locationRequest){
        this.activity = activity;
        this.locationRequest = locationRequest;
    }

    public LocationRequest getLocationRequest() {
        return locationRequest;
    }

    public void setLocationRequest(LocationRequest locationRequest) {
        this.locationRequest = locationRequest;
    }

    public void displayLocationSettingsRequest() {

        if (!hasLocationPerms()) {
            ActivityCompat.requestPermissions(activity, permissionsList(), Globals.LOC_REQUEST_ID);
            return;
        }

        Task<LocationSettingsResponse> task = settingsClient()
                .checkLocationSettings(locationSettingsRequestBuilder(locationRequest).build());

        task.addOnSuccessListener(activity, this);
        task.addOnFailureListener(activity, this);
    }

    private LocationSettingsRequest.Builder locationSettingsRequestBuilder(LocationRequest locationRequest){
        return new LocationSettingsRequest
                .Builder()
                .addLocationRequest(locationRequest)
                .setAlwaysShow(true);
    }

    public void getLastKnownLocation() {
        if (ActivityCompat.checkSelfPermission(activity, android.Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED &&
                ActivityCompat.checkSelfPermission(activity, android.Manifest.permission.ACCESS_COARSE_LOCATION)
                        != PackageManager.PERMISSION_GRANTED) {
            if(e != null) e.onNoPermissionGranted();
            return;
        }

        fusedLocationProviderClient().getLastLocation()
                .addOnSuccessListener(activity, this);
    }


    public void startLocationUpdates() {
        if (ActivityCompat.checkSelfPermission(activity, android.Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED &&
                ActivityCompat.checkSelfPermission(activity, android.Manifest.permission.ACCESS_COARSE_LOCATION)
                        != PackageManager.PERMISSION_GRANTED) {
            if(e != null) e.onNoPermissionGranted();
            return;
        }
        fusedLocationProviderClient().requestLocationUpdates(locationRequest, locationCallback(), null /* Looper */);
    }


    public void stopLocationUpdates() {
        fusedLocationProviderClient().removeLocationUpdates(new LocationCallback());
    }

    private LocationCallback locationCallback(){
        return new LocationCallback() {
            @Override
            public void onLocationResult(LocationResult locationResult) {
                if(e != null) e.onLocationReceived(locationResult);
            }
        };
    }

    private static FusedLocationProviderClient fusedLocationProviderClient(){
        return LocationServices.getFusedLocationProviderClient(activity);
    }

    private SettingsClient settingsClient(){
        return LocationServices.getSettingsClient(activity);
    }

    private String[] permissionsList(){
        return new String[]{
                android.Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
        };
    }

    private boolean hasLocationPerms(){
        return hasGrantedAllPerms(permissionsList());
    }

    private boolean hasGrantedAllPerms(String[] permissionsList){
        boolean allPermsAllowed = true;
        for(int i = 0; i < permissionsList.length; i++){
            if(ContextCompat.checkSelfPermission(activity, permissionsList[i]) !=
                    PackageManager.PERMISSION_GRANTED) allPermsAllowed = false;
        }
        return allPermsAllowed;
    }

    LocationInstanceListener e;
    public void setLocationInstanceListener(LocationInstanceListener e){
        this.e = e;
    }

    public interface LocationInstanceListener {
        void onLocationSettingsResponseSuccess();
        void onLocationSettingsResponseFailed(ResolvableApiException resolvable) throws IntentSender.SendIntentException;
        void onLastKnownLocationReceived(Location locationResult);
        void onLocationReceived(LocationResult locationResult);
        void onNoPermissionGranted();
    }


    @Override
    public void onSuccess(Object o) {
        if(e == null || o == null) return;

        if(o instanceof LocationSettingsResponse){
            e.onLocationSettingsResponseSuccess();
        }

        if(o instanceof Location){
            e.onLastKnownLocationReceived((Location) o);
        }
    }

    @Override
    public void onFailure(@NonNull Exception ex) {
        Log.wtf(Globals.TAG, "ON FAILURE");
        if(e == null) return;

        if (ex instanceof ResolvableApiException) {
            try {
                ResolvableApiException resolvable = (ResolvableApiException) ex;
                e.onLocationSettingsResponseFailed(resolvable);
            } catch (IntentSender.SendIntentException sendEx) {
                Log.i(Globals.TAG, "PendingIntent unable to execute request.");
            }
        }
    }
}
