import UIKit
import Flutter
import YandexMapsMobile

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setLocale("ru_RU")
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "YandexMapKitApiKey") as? String,
      !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      YMKMapKit.setApiKey(apiKey)
    } else {
      print("YandexMapKitApiKey is missing in Info.plist build settings")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}