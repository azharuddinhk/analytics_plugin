//
//  AnalyticsRudderStack.swift
//  Events
//
//  Created by Dipu Singh on 14/06/23.
//

import Foundation
import Rudder
import RudderBranch

class AnalyticsRudderStack{
    static let shareInstance: AnalyticsRudderStack = AnalyticsRudderStack()
    private init(){
        
    }
    func initialisedRudder(writeKey: String, dataUrl : String){
        let config: RSConfig = RSConfig(writeKey: writeKey)
                  .dataPlaneURL(dataUrl)
                  .trackLifecycleEvents(true)
                  .recordScreenViews(true)
        
        RSClient.sharedInstance().configure(with: config)
        RSClient.sharedInstance().addDestination(RudderBranchDestination())

    }
    
    func recordEvents(eventName : String, properties : [String : Any]){
        RSClient.sharedInstance().track(eventName, properties: properties)
    }
    
    func recordScreenEvents(screenName : String){
        RSClient.sharedInstance().screen(screenName)
    }
    
    func recordUser(properties : [String : Any]){
       
        RSClient.sharedInstance().identify(properties["userId"] as? String ?? "user", traits: properties)
    }
    func resetUser(){
        RSClient.sharedInstance().reset()
    }
    
    
}
