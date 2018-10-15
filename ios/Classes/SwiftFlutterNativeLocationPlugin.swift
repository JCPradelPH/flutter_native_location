import Flutter
import UIKit

public class SwiftFlutterNativeLocationPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    if #available(iOS 9.0, *) {
        print("PASOK")
        let flutterPermissions: FlutterPermissions = FlutterPermissions()
        flutterPermissions.initializeChannel(controller: registrar.messenger())
        let flutterLocationApi: FlutterLocationApi = FlutterLocationApi()
        flutterLocationApi.initializeChannels(controller: registrar.messenger())
    }
    
  }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
}
