import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let commentsChannel = FlutterMethodChannel(name: "com.yourapp/comments",
                                              binaryMessenger: controller.binaryMessenger)
    commentsChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getCommentsById" {
        if let args = call.arguments as? [String: Any],
           let url = args["url"] as? String {
          self?.fetchComments(url: url, result: result)
        } else {
          result(FlutterError(code: "ERROR", message: "URL is required", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func fetchComments(url: String, result: @escaping FlutterResult) {
    guard let requestUrl = URL(string: url) else {
      result(FlutterError(code: "ERROR", message: "Invalid URL", details: nil))
      return
    }

    let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
      if let error = error {
        result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
        return
      }
      guard let data = data else {
        result(FlutterError(code: "ERROR", message: "No data received", details: nil))
        return
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        result(json)
      } catch {
        result(FlutterError(code: "ERROR", message: "Failed to parse JSON", details: nil))
      }
    }
    task.resume()
  }
}
