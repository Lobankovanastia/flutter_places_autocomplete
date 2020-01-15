import Flutter
import UIKit

public class SwiftFlutterPlacesAutocompletePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_places_autocomplete", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPlacesAutocompletePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
