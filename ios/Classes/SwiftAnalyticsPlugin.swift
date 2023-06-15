import Flutter
import UIKit


public class SwiftAnalyticsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "analytics_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftAnalyticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
           if call.method == "recordfacebookEvents", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let eventName = args["eventName"] as? String,let eventParams = args["eventAttribute"] as? [String : String]{
                    if let price = args["price"] as? Double{
                        AnalyticsFBEventManager.shared.logEvents(eventName: eventName, value: price, attributes: eventParams)
                        
                    }else{
                        AnalyticsFBEventManager.shared.logEvents(eventName: eventName, attributes: eventParams)
                    }
                }
                
            }else if call.method == "recordAWSEvent", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let eventName = args["eventName"] as? String,let eventParams = args["eventAttribute"] as? [String : String]{
                    AnalyticsPinPointManager.shareInstance.recordEvent(eventName: eventName, attributes: eventParams)
                }
                
            }else if call.method == "initialisedRudderClient", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let writeKey = args["writeKey"] as? String,let dataUrl = args["dataUrl"] as? String{
                    AnalyticsRudderStack.shareInstance.initialisedRudder(writeKey: writeKey, dataUrl: dataUrl)
                }
                
            }else if call.method == "recordRudderStackEvents", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let eventName = args["eventName"] as? String,let eventParams = args["eventAttribute"] as? [String : Any]{
                    AnalyticsRudderStack.shareInstance.recordEvents(eventName: eventName, properties: eventParams)
                }
                
            }else if call.method == "recordRudderStackScreenEvent", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let screenName = args["screenName"] as? String {
                    AnalyticsRudderStack.shareInstance.recordScreenEvents(screenName: screenName)
                }
                
            }else if call.method == "recordRudderStackUserEvent", let args = call.arguments as? [String : Any]{
                print(">>>>>>>>>>", args)
                if let eventParams = args as? [String : Any]{
                    AnalyticsRudderStack.shareInstance.recordUser(properties : eventParams)
                }
                
            }else if call.method == "resetRudderStackUser"{
              AnalyticsRudderStack.shareInstance.resetUser()
                
            }else{
              result("iOS " + UIDevice.current.systemVersion)
            }
   
  }

}
