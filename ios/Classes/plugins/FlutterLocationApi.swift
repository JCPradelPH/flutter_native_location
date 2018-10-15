//
//  FlutterLocationApi.swift
//  flutter_native_location
//
//  Created by JC Pradel on 15/10/2018.
//

import Foundation
import CoreLocation

import Flutter

@available(iOS 9.0, *)
class FlutterLocationApi: FlutterStreamHandler, LocationInstanceListener {
    
    var flutterResult: FlutterResult?
    var flutterEventSink: FlutterEventSink?
    var locationInstance: LocationInstance?
    
    func initializeChannels(controller: FlutterBinaryMessenger) {
        methodChannel(controller: controller).setMethodCallHandler(methodCallHandler())
        eventChannel(controller: controller).setStreamHandler(self as? FlutterStreamHandler & NSObjectProtocol)
    }
    
    private func methodChannel(controller : FlutterBinaryMessenger) -> FlutterMethodChannel {
        return FlutterMethodChannel.init(name: Channels.LOCATION_MC.rawValue, binaryMessenger: controller)
    }
    
    
    private func eventChannel(controller : FlutterBinaryMessenger) -> FlutterEventChannel {
        return FlutterEventChannel.init(name: Channels.LOCATION_EC.rawValue, binaryMessenger: controller)
    }
    
    private func methodCallHandler() -> FlutterMethodCallHandler {
        return {
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            self.flutterResult = result
            
            switch call.method {
                
            case LocationMethods.GET_LAST_KNOWN_LOC.rawValue:
                self.locationInstance = LocationInstance()
                self.locationInstance!.setLocationInstanceListener(e: self)
                self.locationInstance!.getLastKnownLocation()
                break
                
            default: result(FlutterMethodNotImplemented)
            }
            
        }
    }
    
    private func stringifiedJSON(object: Dictionary<String, Any>) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: object)
        return String(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("ON LISTEN")
        self.flutterEventSink = events
        if (self.locationInstance == nil) {
            self.locationInstance = LocationInstance()
            self.locationInstance!.setLocationInstanceListener(e: self)
        }
        self.locationInstance!.locationManager.startUpdatingLocation()
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        guard self.locationInstance != nil else {return nil}
        self.locationInstance!.locationManager.stopUpdatingLocation()
        print("STOPPED STREAMED LOCATION LISTENING")
        return nil
    }
    
    func onPermissionDenied() {
        guard self.flutterResult != nil else{return}
        let resp = [
            "status": "error",
            "message": "No location permission"
        ]
        self.flutterResult!(stringifiedJSON(object: resp))
    }
    
    func onLocationUpdate(manager: CLLocationManager, locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else {return}
        let resp = [
            "status": "success",
            "longitude": location.longitude,
            "latitude": location.latitude,
            ] as [String : Any]
        
        if(self.flutterResult != nil){
            self.flutterResult!(stringifiedJSON(object: resp))
        }
        
        if(self.flutterEventSink != nil){
            self.flutterEventSink!(stringifiedJSON(object: resp))
        }
        
    }
    
}
