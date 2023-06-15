//
//  AnalyticsFBEventManager.swift
//  HealthKartApp
//
//  Created by Dipu Singh on 01/04/22.
//

import Foundation
import FBSDKCoreKit
class  AnalyticsFBEventManager{
    static let shared = AnalyticsFBEventManager()
    private init(){
        
    }
    
    
    func logEvents(eventName: String){
        AppEvents.shared.logEvent(AppEvents.Name(eventName))
    }
    
    func logEvents(eventName: String, attributes: [String: Any]){
        var fbParams = [AppEvents.ParameterName : Any]()
        for key in attributes.keys{
            fbParams[(key as NSString) as AppEvents.ParameterName] = attributes[key]
        }
        AppEvents.shared.logEvent(AppEvents.Name(eventName), parameters: fbParams)
    }
    
    func logEvents(eventName: String, value: Double, attributes: [String: Any]){
        
        var fbParams = [AppEvents.ParameterName : Any]()
        for key in attributes.keys{
            fbParams[(key as NSString) as AppEvents.ParameterName] = attributes[key]
        }
        AppEvents.shared.logEvent(AppEvents.Name(eventName), valueToSum: value, parameters: fbParams)
    }
        
}
