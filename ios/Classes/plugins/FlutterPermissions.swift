//
//  FlutterPermissions.swift
//  flutter_native_location
//
//  Created by JC Pradel on 15/10/2018.
//

import AVFoundation
import Photos
import CoreLocation

import Flutter


@available(iOS 9.0, *)
class FlutterPermissions: LocationInstanceListener {
    
    var flutterResult:FlutterResult?
    var locationInstance: LocationInstance?
    
    func initializeChannel(controller : FlutterBinaryMessenger) {
        
        permissionsChannel(controller: controller).setMethodCallHandler(methodCallHandler())
    }
    
    private func permissionsChannel(controller : FlutterBinaryMessenger) -> FlutterMethodChannel {
        return FlutterMethodChannel.init(name: Channels.PERMISSION_MC.rawValue, binaryMessenger: controller)
    }
    
    private func methodCallHandler() -> FlutterMethodCallHandler {
        return {
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            self.flutterResult = result
            print("Flutter plugin: \(call.method)")
            switch call.method {
            case PermissionMethods.STORAGE.rawValue:
                self.checkStoragePerm()
                break
                
            case PermissionMethods.CAMERA.rawValue:
                self.checkCameraPerm()
                break
                
            case PermissionMethods.LOCATION.rawValue:
                self.locationInstance = LocationInstance()
                self.locationInstance!.setLocationInstanceListener(e: self)
                self.locationInstance!.checkLocationPerm()
                break
                
            default: result(FlutterMethodNotImplemented)
            }
        }
    }
    
    private func checkStoragePerm(){
        if(hasStoragePermission()){
            flutterResult!(0)
            return
        }
        PHPhotoLibrary.requestAuthorization({ status in
            if (status == .authorized){
                self.flutterResult!(0)
            } else {
                self.flutterResult!(1)
            }
        })
    }
    
    private func checkCameraPerm(){
        if(hasCameraPermission()){
            flutterResult!(0)
            return
        }
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if (response) {
                self.flutterResult!(0)
            } else {
                self.flutterResult!(1)
            }
        }
    }
    
    private func hasCameraPermission() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized
    }
    
    private func hasStoragePermission() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized
    }
    
    func onPermissionGranted() {
        flutterResult!(1)
    }
    
    func onPermissionDenied() {
        flutterResult!(0)
    }
}
