//
//  HKPinPointRecordEvent.swift
//  HealthKartApp
//
//  Created by Dipu Singh on 02/03/22.
//

import Foundation
import AWSPinpoint
import UIKit

class AnalyticsPinPointManager{
    private var awsPinPoint: AWSPinpoint?
    private let sessionId = Int(Date().timeIntervalSince1970 * 1000)
    static let shareInstance = AnalyticsPinPointManager()
    private init(){
        
    }
    func setupClient(withLaunchOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        awsPinPoint = AWSPinpoint(configuration:
                                    AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions))
    }
    func recordEvent(eventName: String, attributes: [String : String]?){
        if let pinPointAnalytics = awsPinPoint?.analyticsClient{
            let event = pinPointAnalytics.createEvent(withEventType: eventName)
            if let attribute = attributes{
                for key in attribute.keys{
                    event.addAttribute(attribute[key] ?? "" , forKey: key)
                    
                }
            }
            event.addMetric(NSNumber(value: arc4random() % 655535), forKey: "metric")
            pinPointAnalytics.record(event)
            pinPointAnalytics.submitEvents()
        }
    }
}
