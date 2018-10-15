//
//  Globals.swift
//  flutter_native_location
//
//  Created by JC Pradel on 15/10/2018.
//

import Foundation

enum Channels: String {
    case PERMISSION_MC = "com.mpallc.method.channels/permission"
    case LOCATION_EC = "com.mpallc.event.channels/location"
    case LOCATION_MC = "com.mpallc.event.methods/location"
}

enum PermissionMethods: String {
    case STORAGE = "hasIosStoragePerm"
    case CAMERA = "hasIosCameraPerm"
    case LOCATION = "hasIosLocationPerm"
}

enum LocationMethods: String {
    case GET_LAST_KNOWN_LOC = "getLastKnownLocation"
}
