//
//  LocationInstance.swift
//  flutter_native_location
//
//  Created by JC Pradel on 15/10/2018.
//

import Foundation

import CoreLocation

@available(iOS 9.0, *)
class LocationInstance: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var e: LocationInstanceListener?
    
    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //            self.locationManager.allowDeferredLocationUpdates(untilTraveled: 20.1, timeout: 2000)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFinishDeferredUpdatesWithError error: Error?){
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        guard e != nil else{return}
        
        switch status {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            e?.onPermissionDenied()
            break
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            e?.onPermissionGranted()
            break
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            e?.onPermissionGranted()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            e?.onPermissionDenied()
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            e?.onPermissionDenied()
            break
        }
        
    }
    
    func setLocationInstanceListener(e: LocationInstanceListener){
        self.e = e
    }
    
    private func hasLocationPermission() -> Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    
    func checkLocationPerm(){
        
        guard e != nil else{return}
        
        if(!hasLocationPermission()){
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
        }else{
            e?.onPermissionDenied()
        }
    }
    
    func getLastKnownLocation() {
        guard self.hasLocationPermission() else {
            e?.onPermissionDenied()
            return
        }
        self.locationManager.requestLocation()
    }
    
    private func appState() -> UIApplication.State {
        return UIApplication.shared.applicationState
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard e != nil else{return}
        e?.onLocationUpdate(manager: manager, locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}

protocol LocationInstanceListener{
    func onPermissionGranted() -> Void
    func onPermissionDenied() -> Void
    func onLocationUpdate(manager: CLLocationManager, locations: [CLLocation]) -> Void
}

extension LocationInstanceListener{
    func onPermissionGranted() -> Void {}
    func onPermissionDenied() -> Void {}
    func onLocationUpdate(manager: CLLocationManager, locations: [CLLocation]) -> Void {}
}

