package com.example.flutternativelocation.utils;

public class Globals {
    public static final String PERMISSION_MC = "com.mpallc.method.channels/permission";
    public static final String FACEBOOK_LOGIN_MC = "com.mpallc.method.channels/facebook_login";
    public static final String LOCATION_EC = "com.mpallc.event.channels/location";
    public static final String LOCATION_MC = "com.mpallc.event.methods/location";
    public static final String TOAST_MC = "com.mpallc.method.channels/toast_message";
    public static final String TAG = "MPA-LIB(Android API)";

    public static final int PERM_REQUEST_ID = 1001;
    public static final int LOC_REQUEST_ID = 1002;
    public static final int PERMISSION_GRANTED = 0;
    public static final int PERMISSION_DENIED = 1;

    public static final String PERM_METHOD = "hasPlatformPermission";
    public static final String PERM_LOCATION = "hasAndroidLocationPerm";
    public static final String FB_LOGIN = "getFacebookAuthToken";
    public static final String SHOW_TOAST = "showToastMessage";

    public static final String LOC_METHOD_LAST_KNOWN_LOC = "getLastKnownLocation";
}
