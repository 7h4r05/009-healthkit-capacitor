//
//  ExtensionDelegate.swift
//  WatchApp Watch App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//


import WatchKit
import WatchConnectivity
import CoreData
import HealthKit


class ExtensionDelegate: NSObject, WKApplicationDelegate, WCSessionDelegate {
    override init() {
        super.init()
        assert(WCSession.isSupported(), "WatchConnectivity is required!")
        WCSession.default.delegate = self
        WCSession.default.activate()
        let store = HKHealthStore()
        
        
        let permissions = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        
        let status = store.requestAuthorization(toShare: permissions , read: permissions) { (success, error) in
            
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    }
}
