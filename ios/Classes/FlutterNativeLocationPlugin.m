#import "FlutterNativeLocationPlugin.h"
#import <flutter_native_location/flutter_native_location-Swift.h>

@implementation FlutterNativeLocationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeLocationPlugin registerWithRegistrar:registrar];
}
@end
